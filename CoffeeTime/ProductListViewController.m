//
//  ProductListViewController.m
//  CoffeeTime
//
//  Created by Adam on 15/6/25.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import "ProductListViewController.h"
#import "ProductTableViewCell.h"
#import "Header.h"
#import "ProductTypeModel.h"
#import "ProductModel.h"
#import "ShopCartModel.h"

@interface ProductListViewController () <ProductTableViewCellDelegate, UIAlertViewDelegate>
{
    NSMutableArray *productDataArray;
    NSInteger currentProductClickTag;
}

@end

@implementation ProductListViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self transProductInfo];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"星巴克";
    
    self.navView.backgroundColor = barColor;
    
}

- (void)adjustView
{
    
    [self.confirmView setFrame:CGRectMake(self.confirmView.frame.origin.x, self.view.frame.size.height - self.confirmView.frame.size.height-64, SCREEN_WIDTH, self.confirmView.frame.size.height)];
    
    self.totalNumLabel.layer.cornerRadius = self.totalNumLabel.frame.size.height/2;
    self.totalNumLabel.layer.masksToBounds = YES;
    
    UIButton *btnOK = (UIButton *)[self.confirmView viewWithTag:103];
    btnOK.layer.cornerRadius = 4;
    btnOK.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView的协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [productDataArray count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellID = @"CellID";
    ProductTableViewCell *cell = [self.mTableView dequeueReusableCellWithIdentifier:CellID];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ProductTableViewCell" owner:nil options:nil] lastObject];
        cell.delegate = self;
    }
    
    ProductModel *productModel = productDataArray[indexPath.row];
    [cell addProductUnit:productModel indexPath:indexPath];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    // refeash table
    [self.mTableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}

- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)doConfim:(id)sender {
    
    if ([self.totalNumLabel.text integerValue] > 0) {
    
        [self transShopCartInfo];

    } else {
        
        [self showHUDWithText:@"请先选择商品。"];
    }
}

#pragma mark -- 实现加减按钮点击代理事件
/**
 *  实现加减按钮点击代理事件
 *
 *  @param cell 当前单元格
 *  @param flag 按钮标识
 */
- (void)btnClick:(UITableViewCell *)cell tag:(NSInteger)tag
{
    
    currentProductClickTag = tag;
    
    if ([[FMDBConnection instance] isNeedClearShopCart:[AppManager instance].selStoreId]) {
        // 已经在其他商家选择过商品
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"清空购物车" message:@"您已选择了美食，确定要切换商家。\n 清空购物车才能加入所点美食。" delegate:self cancelButtonTitle:@"考虑下" otherButtonTitles:@"立即清空", nil];
        [alertView show];
    } else {
        // 1，购物车为空； 2，或者已经在该商家点过
        [self handleShopCart:currentProductClickTag];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 1) {
        DLog(@"考虑下");
    } else {
        DLog(@"立即清空");
        
        [[FMDBConnection instance] delAllShopCartTableData];
        
        [self handleShopCart:currentProductClickTag];
    }
}

- (void)handleShopCart:(NSInteger)tag
{
    int rowIndex = tag / 10000;
    
    int yushu = tag % 10000;
    int goodsTypeListIndex = (yushu - 10) / 10;
    
    if (yushu % 10 == 0) {
        // -
        [self doHandleMethod:1 rowIndex:rowIndex goodsTypeListIndex:goodsTypeListIndex];
    } else if(yushu % 10 == 1) {
        // +
        [self doHandleMethod:2 rowIndex:rowIndex goodsTypeListIndex:goodsTypeListIndex];
    }
    
    //刷新表格
    [self.mTableView reloadData];
}

- (void)doHandleMethod:(NSInteger)handleType rowIndex:(NSInteger)rowIndex goodsTypeListIndex:(NSInteger)goodsTypeListIndex
{
    
    ProductModel *productModel = nil;
    ProductTypeModel *productTypeModel = nil;
    
    if (handleType == 1) {
        
        //做减法
        //先获取到当期行数据源内容，改变数据源内容，刷新表格
        productModel = productDataArray[rowIndex];
        productTypeModel = productModel.productTypeArray[goodsTypeListIndex];
        
        if (productTypeModel.productNum > 0)
        {
            productTypeModel.productNum --;
        }
        
    } else if (handleType == 2) {
        
        //做加法
        productModel = productDataArray[rowIndex];
        productTypeModel = productModel.productTypeArray[goodsTypeListIndex];
        productTypeModel.productNum ++;
    }
    
    [self doSaveLocalDB:productModel productTypeModel:productTypeModel];
    
    [self showShopCartNumber];
}

#pragma mark - show shopCart Number
- (void)showShopCartNumber
{
    NSMutableArray *shopCartShowNumber = [[FMDBConnection instance] getShopCartShowNumber:[AppManager instance].selStoreId];
    if ([shopCartShowNumber count] > 0) {

        self.totalNumLabel.text = shopCartShowNumber[0];
        self.totalPriceLabel.text = [NSString stringWithFormat:@"￥%@", shopCartShowNumber[1]];
    } else {
        
        self.totalNumLabel.text = @"0";
        self.totalPriceLabel.text = @"￥0";
    }
}

- (void)doSaveLocalDB:(ProductModel *)productModel productTypeModel:(ProductTypeModel *)productTypeModel
{
    NSMutableDictionary *shopCartDic = [[NSMutableDictionary alloc] init];
    
    [shopCartDic setObject:[AppManager instance].selStoreName forKey:@"shopName"];
    [shopCartDic setObject:[AppManager instance].selStoreId forKey:@"shopId"];
    [shopCartDic setObject:productModel.productId forKey:@"commodityId"];
    [shopCartDic setObject:productModel.productName forKey:@"commodityName"];
    [shopCartDic setObject:productTypeModel.unitId forKey:@"commodityTypeId"];
    [shopCartDic setObject:productTypeModel.unitPrice forKey:@"commodityPrice"];
    [shopCartDic setObject:productModel.productNo forKey:@"commodityNumber"];
    [shopCartDic setObject:productModel.productKind forKey:@"commodityClass"];
    [shopCartDic setObject:productTypeModel.unitName forKey:@"commodityTypeName"];
    [shopCartDic setObject:[NSNumber numberWithInteger:productTypeModel.productNum] forKey:@"commodityAmount"];
    
    ShopCartModel *shopCartModel = [[ShopCartModel alloc] initWithDict:shopCartDic];
    [[FMDBConnection instance] updateShopCartLogic:shopCartModel];
}

#pragma mark - Trans Data
#pragma mark 商户信息
- (void)transProductInfo
{
    
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] init];
    
    [dataDict setObject:[AppManager instance].selStoreId forKey:@"shopDetailId"];
    [dataDict setObject:[AppManager instance].userTicket forKey:@"page"];
    [dataDict setObject:[AppManager instance].userTicket forKey:@"rows"];
    
    NSMutableDictionary *paramDict = [CommonUtils getParamDict:@"getCommodityInfo"
                                                      dataDict:dataDict];
    
    [self showHUDWithText:@"正在加载"
                   inView:self.view
              methodBlock:^(CompletionBlock completionBlock, ATMHud *hud)
     {
         
         [HttpRequestData dataWithDic:paramDict
                          requestType:POST_METHOD
                            serverUrl:HOST_URL
                             andBlock:^(NSString *requestStr) {
                                 
                                 if (completionBlock) {
                                     completionBlock();
                                 }
                                 
                                 if ([requestStr isEqualToString:@"Start"]) {
                                     
                                     DLog(@"Start");
                                 } else if([requestStr isEqualToString:@"Failed"]) {
                                     
                                     DLog(@"Failed");
                                     
                                 } else {
                                     
                                     NSDictionary* backDic = [HttpRequestData jsonValue:requestStr];
                                     NSLog(@"requestStr = %@", backDic);
                                     
                                     if (backDic != nil) {
                                         
                                         NSString *errCodeStr = (NSString *)[backDic valueForKey:@"code"];
                                         
                                         if ( [errCodeStr integerValue] == 0 ) {
                                             
                                             NSArray *resultArray = (NSArray *)[(NSArray *)[backDic valueForKey:@"result"] valueForKey:@"commoditylist"];
                                             
                                             productDataArray = [[NSMutableArray alloc] init];
                                             
                                             NSInteger productCount = [resultArray count];
                                             
                                             for (NSInteger productIndex = 0; productIndex < productCount; productIndex++) {
                                                 
                                                 // product type list
                                                 NSMutableArray *typeArray = [NSMutableArray array];
                                                 
                                                 NSMutableDictionary *productDic = (NSMutableDictionary *)resultArray[productIndex];
                                                 
                                                 NSArray *productTypeArray = (NSArray *)[productDic valueForKey:@"commodityTypeList"];
                                                 NSInteger productTypeNumber = [productTypeArray count];
                                                 
                                                 for (NSInteger typeIndex = 0; typeIndex < productTypeNumber; typeIndex ++) {

                                                     NSDictionary *productTypeDic = (NSDictionary *)productTypeArray[typeIndex];
                                                     
                                                     ProductTypeModel *productTypeModel = [[ProductTypeModel alloc] initWithDict:productTypeDic];
                                                     [typeArray addObject:productTypeModel];
                                                 }
                                                 
                                                 ProductModel *productModel = [[ProductModel alloc] initWithDict:productDic typeArray:typeArray];
                                                 [productDataArray addObject:productModel];
                                                 
                                             }
                                             
                                             [self loadShopCartData2Show];
                                             
                                             [self.mTableView reloadData];
                                         } else {
                                             
                                             [self showHUDWithText:[backDic valueForKey:@"msg"]];
                                         }
                                     }
                                 }
                             }];
     }];
}

- (void)transShopCartInfo
{
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] init];
    
    [dataDict setObject:[AppManager instance].selStoreId forKey:@"shopId"];
    
    if ([[FMDBConnection instance] getAllShopCartDataFromDB]) {
        
        NSMutableArray *productListArray = [NSMutableArray array];
        
        NSMutableArray *shopCartArray = [[FMDBConnection instance] getStoreAllCartFromDB:[AppManager instance].selStoreId];
        
        NSInteger shopCartNum = [shopCartArray count];
        for (NSInteger shopCartIndex = 0; shopCartIndex < shopCartNum; shopCartIndex++) {
            
            ShopCartModel *shopCartModel = shopCartArray[shopCartIndex];
            
            NSMutableDictionary *productDict = [[NSMutableDictionary alloc] init];
            
            [productDict setObject:shopCartModel.productId forKey:@"commodityId"];
            [productDict setObject:shopCartModel.unitId forKey:@"commodityTypeId"];
            [productDict setObject:[NSString stringWithFormat:@"%@", shopCartModel.unitPrice] forKey:@"commodityPrice"];
            [productDict setObject:[NSString stringWithFormat:@"%@", shopCartModel.shopCartNum] forKey:@"commodityAmount"];
            
            [productListArray addObject:productDict];
        }
        
        [dataDict setObject:productListArray forKey:@"commodityList"];
    }

    
    NSMutableDictionary *paramDict = [CommonUtils getParamDict:@"addshoppingCart"
                                                      dataDict:dataDict];
    
    [self showHUDWithText:@"正在加载"
                   inView:self.view
              methodBlock:^(CompletionBlock completionBlock, ATMHud *hud)
     {
         
         [HttpRequestData dataWithDic:paramDict
                          requestType:POST_METHOD
                            serverUrl:HOST_URL
                             andBlock:^(NSString *requestStr) {
                                 
                                 if (completionBlock) {
                                     completionBlock();
                                 }
                                 
                                 if ([requestStr isEqualToString:@"Start"]) {
                                     
                                     DLog(@"Start");
                                 } else if([requestStr isEqualToString:@"Failed"]) {
                                     
                                     DLog(@"Failed");
                                     
                                 } else {
                                     
                                     NSDictionary* backDic = [HttpRequestData jsonValue:requestStr];
                                     NSLog(@"requestStr = %@", backDic);
                                     
                                     if (backDic != nil) {
                                         
                                         NSString *errCodeStr = (NSString *)[backDic valueForKey:@"code"];
                                         
                                         if ( [errCodeStr integerValue] == 0 ) {
                                             
                                             // 进入购物车界面
                                             ShopCartViewController *vc = [ShopCartViewController new];
                                             [self.navigationController pushViewController:vc animated:YES];
                                         } else {
                                             
                                             [self showHUDWithText:[backDic valueForKey:@"msg"]];
                                         }
                                     }
                                 }
                             }];
     }];
}

#pragma mark - load Shop Cart data
- (void)loadShopCartData2Show
{
    if ([[FMDBConnection instance] getAllShopCartDataFromDB]) {
        
        NSMutableArray *shopCartArray = [[FMDBConnection instance] getStoreAllCartFromDB:[AppManager instance].selStoreId];
        
        NSInteger allProductNum = [productDataArray count];
        for (NSInteger index = 0; index < allProductNum; index ++) {
            ProductModel *productModel = productDataArray[index];
            NSMutableArray *productTypeArray = productModel.productTypeArray;
            
            NSInteger typeNum = [productTypeArray count];
            for (NSInteger typeIndex = 0; typeIndex < typeNum; typeIndex ++) {
                
                ProductTypeModel *productTypeModel = productTypeArray[typeIndex];
                
                NSInteger shopCartNum = [shopCartArray count];
                for (NSInteger shopCartIndex = 0; shopCartIndex < shopCartNum; shopCartIndex++) {

                    ShopCartModel *shopCartModel = shopCartArray[shopCartIndex];
                    if ([shopCartModel.productId isEqualToString:productModel.productId]  && [shopCartModel.unitId isEqualToString:productTypeModel.unitId]) {
                        
                        productTypeModel.productNum = [shopCartModel.shopCartNum integerValue];
                    }
                }
            }
        }
    }
    
    [self showShopCartNumber];
}

- (void)loadTestData
{
    productDataArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<10; i++){
        
        // product type list
        NSMutableArray *typeArray = [NSMutableArray array];
        
        NSArray *array = [NSArray arrayWithObjects:@"大杯",@"中杯",@"小杯", nil];
        
        for (int m=0; m<3; m++) {
            
            NSMutableDictionary *produtcTypeDict = [NSMutableDictionary dictionary];
            [produtcTypeDict setValue:array[m] forKey:@"unitName"];
            [produtcTypeDict setValue:@"25" forKey:@"unitPrice"];
            [produtcTypeDict setValue:0 forKey:@"productNum"];
            
            ProductTypeModel *productTypeModel = [[ProductTypeModel alloc] initWithDict:produtcTypeDict];
            [typeArray addObject:productTypeModel];
        }
        
        // product list
        NSMutableDictionary *productDict = [NSMutableDictionary dictionary];
        [productDict setValue:@"冰激凌" forKey:@"commodityName"];
        [productDict setValue:typeArray forKey:@"productTypeArray"];
        
        ProductModel *productModel = [[ProductModel alloc] initWithDict:productDict typeArray:typeArray];
        [productDataArray addObject:productModel];
    }
}

@end
