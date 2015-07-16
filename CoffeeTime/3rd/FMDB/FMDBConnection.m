
#import "FMDBConnection.h"
#import "GlobalConstants.h"
#import "AppManager.h"
#import "ShopCartModel.h"

static FMDBConnection *instance = nil;

@implementation FMDBConnection

#pragma mark - singleton method

// 获取一个instance实例，如果有必要的话，实例化一个
+ (FMDBConnection *)instance {
    
    if (instance == nil) {
        instance = [[super allocWithZone:NULL] init];
    }
    
    return instance;
}

// 当第一次使用这个单例时，会调用这个init方法。
- (id)init
{
    self = [super init];
    
    if (self) {
        // 通常在这里做一些相关的初始化任务
        [self setup];
    }
    
    return self;
}

// 这个dealloc方法永远都不会被调用--因为在程序的生命周期内容，该单例一直都存在。（所以该方法可以不用实现）
- (void)dealloc
{
    
}

// 通过返回当前的instance实例，就能防止实例化一个新的对象。
+ (id)allocWithZone:(NSZone*)zone {
    return [self instance];
}

// 同样，不希望生成单例的多个拷贝。
- (id)copyWithZone:(NSZone *)zone {
    return self;
}

#pragma mark - init db
- (NSString *)documentsDirectory {
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
}

- (NSString *)getDBPath:(NSString *)dbFileName {
    
    NSString *docDir = [self documentsDirectory];
    NSString *dbPath = [docDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_V%@.sqlite", dbFileName, VERSION]];
    return dbPath;
}

- (void)setup {
    
    if (self.db == nil) {
        self.db = [FMDatabase databaseWithPath:[self getDBPath:PROJECT_DB_NAME]];
    }
    
    if ([self openDB]) {
        [self createTables];
    }
}

- (BOOL)openDB {
    return [self.db open];
}

- (BOOL)closeDB {
    return [self.db close];
}


//-------------------------------ShopCart-----------------------------
- (void)createTables {
    
    BOOL res = NO;
    
    // storeId TEXT,    //门店Id
    // productId TEXT,  //商品Id
    // typeId TEXT,     //种类Id
    // shopCartNum int,//商品数量
    // unitPrice TEXT,//商品价格
    // storeName TEXT,  //门店名称
    // productName TEXT,//商品名称
    // unitName TEXT,   //种类名称
    // productNo TEXT //商品编码
    
    NSString *createTabMsg = @"create table if not exists ShopCart ( storeId TEXT,                                                                                        productId TEXT, typeId TEXT, shopCartNum int,  unitPrice int,  storeName TEXT,                                                                                               productName TEXT, unitName TEXT,  productNo TEXT, PRIMARY KEY (storeId, productId, typeId) )";
    
    res = [self.db executeUpdate:createTabMsg];
    
    if (!res) {
        DLog(@"error when creating ShopCart table");
    } else {
        DLog(@"success to creating ShopCart table");
    }
    
}
//------------------------------------------------------------


#pragma mark - do business action
- (void)insertShopCarModelDB:(ShopCartModel *)shopInfo
{
    [self.db beginTransaction];
    BOOL isRoolBack = NO;
    
    
    static NSString *sql = @"INSERT INTO ShopCart VALUES(?,?,?,?,?, ?,?,?,?)";
    
    @try
    
    {
        NSArray *argumentsArray = [[NSArray alloc] initWithObjects:
                                   shopInfo.shopId,
                                   shopInfo.productId,
                                   shopInfo.unitId,
                                   shopInfo.shopCartNum,
                                   shopInfo.unitPrice,
                                   shopInfo.shopName,
                                   shopInfo.productName,
                                   shopInfo.unitName,
                                   shopInfo.productNo,
                                   nil];
        
        BOOL res = [self.db executeUpdate:sql
                     withArgumentsInArray:argumentsArray];
        
        if (!res) {
            DLog(@"insert ShopCart error !");
        }
    }
    @catch (NSException *exception)
    {
        NSLog(@"Exception name=%@",exception.name);
        NSLog(@"Exception reason=%@",exception.reason);
        isRoolBack = YES;
        [self.db rollback];
    }
    @finally
    {
        if (!isRoolBack) {
            [self.db commit];
        }
    }
}

#pragma mark - do business action
- (void)insertAllShopCarModelDB:(NSArray *)userList
{
    [self.db beginTransaction];
    BOOL isRoolBack = NO;
    
    ShopCartModel *shopInfo = nil;
    static NSString *sql = @"INSERT INTO ShopCart VALUES(?,?,?,?,?, ?,?,?,?)";
    
    @try
    {
        
        for (int i = 0; i < userList.count; i++) {
            shopInfo = [userList objectAtIndex:i];
            
            NSArray *argumentsArray = [[NSArray alloc] initWithObjects:
                                       shopInfo.shopId,
                                       shopInfo.productId,
                                       shopInfo.unitId,
                                       shopInfo.shopCartNum,
                                       shopInfo.unitPrice,
                                       shopInfo.shopName,
                                       shopInfo.productName,
                                       shopInfo.unitName,
                                       shopInfo.productNo,
                                       nil];
            
            BOOL res = [self.db executeUpdate:sql
                         withArgumentsInArray:argumentsArray];
            
            if (!res) {
                DLog(@"insert ShopCart error !");
            }
        }
    }
    @catch (NSException *exception)
    {
        NSLog(@"Exception name=%@",exception.name);
        NSLog(@"Exception reason=%@",exception.reason);
        isRoolBack = YES;
        [self.db rollback];
    }
    @finally
    {
        if (!isRoolBack) {
            [self.db commit];
        }
    }
}

- (BOOL)getAllShopCartDataFromDB
{
    NSInteger count = 0;
    
    NSString *sql = @"select * from ShopCart";
    FMResultSet *res = [self.db executeQuery:sql];
    
    while ([res next]) {
        count ++;
    }
    
    if (count > 0) {
        return YES;
    }
    
    return NO;
}

- (BOOL)getCurrentShopCartDataFromDB:(NSString *)storeId
{
    NSInteger count = 0;
    
    NSString *sql = [NSString stringWithFormat:@"select * from ShopCart where storeId == %@", storeId];
    FMResultSet *res = [self.db executeQuery:sql];
    
    while ([res next]) {
        count ++;
    }
    
    if (count > 0) {
        return YES;
    }
    
    return NO;
}

- (NSMutableArray *)getStoreAllCartFromDB:(NSString *)storeId
{
    
    NSMutableArray *shopCartArray = [NSMutableArray array];
    
    NSString *sql = [NSString stringWithFormat:@"select * from ShopCart where storeId == %@ order by productNo desc", storeId];
    FMResultSet *res = [self.db executeQuery:sql];
    
    while ([res next]) {
        [shopCartArray addObject:[self parseShopCartModel:res]];
    }
    
    return shopCartArray;
}

- (ShopCartModel *)parseShopCartModel:(FMResultSet *)res
{
    
    ShopCartModel *shopCartModel = [[ShopCartModel alloc] init];
    
    shopCartModel.shopId = [res stringForColumn:@"storeId"];
    shopCartModel.productId = [res stringForColumn:@"productId"];
    shopCartModel.unitId = [res stringForColumn:@"typeId"];
    shopCartModel.shopCartNum = @([res intForColumn:@"shopCartNum"]);
    shopCartModel.unitPrice = @([res intForColumn:@"unitPrice"]);
    shopCartModel.shopName = [res stringForColumn:@"storeName"];
    shopCartModel.productName = [res stringForColumn:@"productName"];
    shopCartModel.unitName = [res stringForColumn:@"unitName"];
    shopCartModel.productNo=[res stringForColumn:@"productNo"];
    
    return shopCartModel;
}

- (void)delShopCartTableBy:(ShopCartModel *)shopCart
{
    
    NSString *sql = [NSString stringWithFormat:@"delete from ShopCart where storeId == %@ and productId == %@ and typeId == %@", shopCart.shopId, shopCart.productId, shopCart.unitId];
    FMResultSet *res = [self.db executeQuery:sql];
    
    if ([res next]) {
    }
}

- (void)delAllShopCartTableData
{
    
    NSString *sql = @"delete from ShopCart";
    FMResultSet *res = [self.db executeQuery:sql];
    
    if ([res next]) {
    }
}

- (BOOL)isExistShopCat:(ShopCartModel *)shopInfo
{
    
    NSInteger index = 0;
    
    NSString *sql = [NSString stringWithFormat:@"select * from ShopCart where storeId == %@ and productId == %@ and typeId == %@", shopInfo.shopId, shopInfo.productId, shopInfo.unitId];
    FMResultSet *res = [self.db executeQuery:sql];
    
    while ([res next]) {
        index ++;
    }
    
    if (index > 0) {
        return YES;
    }
    
    return NO;
}

- (NSMutableArray *)getShopCartShowNumber
{
    
    NSMutableArray *showNumberArray = [NSMutableArray array];
    
    NSString *sql = @"SELECT storeId, SUM(shopCartNum), SUM(shopCartNum * unitPrice / 100) from ShopCart GROUP BY storeId ORDER BY storeId";
    FMResultSet *res = [self.db executeQuery:sql];
    
    while ([res next]) {
        
        [showNumberArray addObject:[res stringForColumnIndex:1]];
        [showNumberArray addObject:[res stringForColumnIndex:2]];
    }
    
    return showNumberArray;
}

#pragma mark - update business action
- (void)updateShopCartDB:(ShopCartModel *)shopCart
{
    [self.db beginTransaction];
    BOOL isRoolBack = NO;
    
    static NSString *sql = @"update ShopCart set shopCartNum = ? where storeId == ? and productId == ? and typeId == ?";
    
    @try
    {
        
        BOOL res = [self.db executeUpdate:sql
                     withArgumentsInArray:@[shopCart.shopCartNum,
                                            shopCart.shopId,
                                            shopCart.productId,
                                            shopCart.unitId]];
        
        if (!res) {
            DLog(@"update ShopCart error!");
        }
    }
    @catch (NSException *exception)
    {
        NSLog(@"Exception name=%@", exception.name);
        NSLog(@"Exception reason=%@", exception.reason);
        isRoolBack = YES;
        [self.db rollback];
    }
    @finally
    {
        if (!isRoolBack) {
            [self.db commit];
        }
    }
}

- (void)updateShopCartLogic:(ShopCartModel *)shopCarModel
{
    NSInteger shopCartAmount = [shopCarModel.shopCartNum integerValue];
    
    if (shopCartAmount > 0) {
        
        BOOL isExit = [[FMDBConnection instance] isExistShopCat:shopCarModel];
        
        // 是否存在
        if (isExit == YES) {
            
            // 修改
            [[FMDBConnection instance] updateShopCartDB:shopCarModel];
            
        } else {
            
            // 新建
            [[FMDBConnection instance] insertShopCarModelDB:shopCarModel];
            
        }
    } else {
        
        // 删除
        [[FMDBConnection instance] delShopCartTableBy:shopCarModel];
    }
}

- (BOOL)isNeedClearShopCart:(NSString *)storeId
{
    if (![self getAllShopCartDataFromDB]) {
        // 购物车没有数据
    } else {
        // 购物车有数据
        if (![self getCurrentShopCartDataFromDB:storeId]) {
            // 但不是当前门店数据
            return YES; // 提示需要清理购物车【目前一个订单只支持一家门店】
        } else {
            // 是当前门店数据
        }
    }
    
    return NO;
}

@end
