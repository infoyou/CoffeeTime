//
//  HomeViewController.m
//  CoffeeTime
//
//  Created by Adam on 15/6/24.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import "HomeViewController.h"
#import "SDCycleScrollView.h"
#import "StoreTableViewCell.h"
#import "CommonWebViewController.h"
#import "Header.h"
#import "StoreModel.h"

@interface HomeViewController () <SDCycleScrollViewDelegate>

@property (nonatomic, retain) NSMutableArray *storeArray;
@property (nonatomic, retain) NSArray *typeColor;

@end

@implementation HomeViewController

@synthesize storeArray;
@synthesize typeColor;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Tab Bar
    [self showOrHideTabBar:NO];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)adjustView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.mTableView.separatorStyle = NO;
    
    [self loadBannerView];
    
    [self transUserLogin];
}

- (void)initData
{
    typeColor = [NSArray arrayWithObjects:@"0xa47f64", @"0xf89dbb", @"0xf9e165", @"0xffb04a", @"0x64add5", @"0xa47f64", @"0xa47f64", @"0xa47f64", nil];
    
    storeArray = [NSMutableArray array];
}

- (void)loadBannerView
{
    // 情景一：采用本地图片实现
    NSArray *images = @[[UIImage imageNamed:@"个人"],
                        [UIImage imageNamed:@"个人"],
                        [UIImage imageNamed:@"个人"],
                        [UIImage imageNamed:@"个人"]
                        ];
    
    // 情景二：采用网络图片实现
    NSArray *imagesURL = @[
                           [NSURL URLWithString:@"http://image.shanghaiwow.com:1234/uploads/appimage/193x153/20140616_1113122.jpg"],
                           [NSURL URLWithString:@"http://www.icare99.com.tw/imgs/question/201311190009421.jpg"],
                           [NSURL URLWithString:@"http://image.shanghaiwow.com:1234/uploads/appimage/193x153/20140325_1136534.jpg"],
                           [NSURL URLWithString:@"http://image.shanghaiwow.com:1234/uploads/appimage/193x153/20120828_1545003.jpg"]
                           ];
    
    // 情景三：图片配文字
    NSArray *titles = @[@"喝杯时光I",
                        @"喝杯时光II",
                        @"喝杯时光III",
                        @"喝杯时光IV"
                        ];
    
    CGFloat w = self.view.bounds.size.width;
    
    /*
     // 本地加载 --- 创建不带标题的图片轮播器
     SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, w, 128) imagesGroup:images];
     cycleScrollView.delegate = self;
     cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
     //         --- 轮播时间间隔，默认1.0秒，可自定义
     cycleScrollView.autoScrollTimeInterval = 2.0;
     [self.bannerView addSubview:cycleScrollView];
     */
    
    // 网络加载 --- 创建带标题的图片轮播器
    SDCycleScrollView *webSDCycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, w, 128) imageURLsGroup:imagesURL];
    webSDCycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    webSDCycleScrollView.delegate = self;
    webSDCycleScrollView.titlesGroup = titles;
    webSDCycleScrollView.dotColor = [UIColor whiteColor];
    // 自定义分页控件小圆标颜色
    //         --- 轮播时间间隔，默认1.0秒，可自定义
    webSDCycleScrollView.autoScrollTimeInterval = 2.0;
    
    UIView *bannerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 128)];
    [bannerView addSubview:webSDCycleScrollView];
    
    self.mTableView.tableHeaderView = bannerView;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        webSDCycleScrollView.imageURLsGroup = imagesURL;
    });
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    DLog(@"SDCycleScrollViewDelegate method %d", index);
    
    // 积分
    CommonWebViewController *webVC = [[CommonWebViewController alloc] init];
    
    webVC.strTitle = @"测试";
    webVC.strUrl = [NSString stringWithFormat:@"http://www.baidu.com"];
    
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView的协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [storeArray count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellID = @"CellID";
    StoreTableViewCell *cell = [self.mTableView dequeueReusableCellWithIdentifier:CellID];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"StoreTableViewCell" owner:nil options:nil] lastObject];
    }
    
    //cell.textLabel.text=[NSString stringWithFormat:@"第%d家",indexPath.row];
    int row = indexPath.row;
    StoreModel *storeModel = (StoreModel *)storeArray[row];
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:11];
    nameLabel.text = storeModel.name;
    
    UILabel *distanceLabel = (UILabel *)[cell viewWithTag:12];
    distanceLabel.text = [NSString stringWithFormat:@"%@km", storeModel.distance];
    
    UIButton *btnBuy = (UIButton *)[cell viewWithTag:20];
    btnBuy.layer.cornerRadius = 4;
    btnBuy.layer.masksToBounds = YES;
    [btnBuy addTarget:self action:@selector(doBuy:event:) forControlEvents:UIControlEventTouchUpInside];
    
    // Mark
    NSInteger typeCount = [storeModel.productTypeArray count];
    
    // 清空所有类型
    for (NSInteger btnIndex=0; btnIndex<=7; btnIndex++) {
        
        UIButton *btnMark = (UIButton *)[cell viewWithTag:30+btnIndex];
        btnMark.hidden = YES;
    }
    
    // 加载实际类型
    for (NSInteger i=0; i<typeCount; i++) {
        
        UIButton *btnMark = (UIButton *)[cell viewWithTag:30+i];
        btnMark.backgroundColor = HEX_COLOR(typeColor[i]);
        btnMark.layer.cornerRadius = 4;
        btnMark.layer.masksToBounds = YES;
        
        [btnMark setTitle:[storeModel.productTypeArray[i] objectForKey:@"typeName"] forState:UIControlStateNormal];
        btnMark.hidden = NO;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 点击商家明细
    [self showHUDWithText:@"商家明细"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 102;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 7;
}

#pragma mark - CLLocationManagerDelegate method
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    self.currentLocation = [locations lastObject];
    
    [AppManager instance].latitude = [NSString stringWithFormat:@"%g", self.currentLocation.coordinate.latitude];
    [AppManager instance].longitude = [NSString stringWithFormat:@"%g", self.currentLocation.coordinate.longitude];
    
    self.locationTxt.text = [NSString stringWithFormat:@"纬度%@/经度%@",[AppManager instance].latitude, [AppManager instance].longitude];
}

- (IBAction)goSearchStore:(id)sender {
    
    [self showHUDWithText:@"商家查询"];
}

- (void)doBuy:(id)sender event:(id)event
{
    
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.mTableView];
    
    NSIndexPath *indexPath = [self.mTableView indexPathForRowAtPoint:currentTouchPosition];
    if (indexPath != nil)
    {
        StoreModel *storeModel = (StoreModel *)storeArray[indexPath.row];
     
        [AppManager instance].selStoreId = storeModel.storeId;
        [AppManager instance].selStoreName = storeModel.name;
        
        ProductListViewController *vc = [[ProductListViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - 交互
#pragma mark 用户登录
- (void)transUserLogin
{
    
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] init];
    [dataDict setObject:@"13524010590" forKey:@"username"];
    [dataDict setObject:[AppManager instance].userPswd forKey:@"password"];
    
    NSMutableDictionary *paramDict = [CommonUtils getParamDict:@"userLogin"
                                                      dataDict:dataDict];
    
    [self showHUDWithText:@"正在加载"
                   inView:self.view
              methodBlock:^(CompletionBlock completionBlock, ATMHud *hud)
     {
         
         [HttpRequestData dataWithDic:paramDict
                          requestType:POST_METHOD
                            serverUrl:HOST_URL
                             andBlock:^(NSString*requestStr) {
                                 
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
                                             [AppManager instance].userTicket = (NSString *)[[backDic valueForKey:@"result"] valueForKey:@"ticket"];
                                             [AppManager instance].userId = (NSString *)[[backDic valueForKey:@"result"] valueForKey:@"userId"];
                                             
                                             [self transUserInfo];
                                         } else {
                                             
                                             [self showHUDWithText:[backDic valueForKey:@"msg"]];
                                         }
                                     }
                                 }
                             }];
     }];
}

#pragma mark 用户信息
- (void)transUserInfo
{
    
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] init];
    
    [dataDict setObject:[AppManager instance].userId forKey:@"userId"];
    [dataDict setObject:[AppManager instance].userTicket forKey:@"ticket"];
    
    NSMutableDictionary *paramDict = [CommonUtils getParamDict:@"userInfo"
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
                                             
                                             NSDictionary *resultDic =[backDic valueForKey:@"result"];
                                             [AppManager instance].userName = (NSString *)[resultDic valueForKey:@"username"];//用户名
                                             [AppManager instance].userNickName = (NSString *)[resultDic valueForKey:@"nickname"];//昵称
                                             [AppManager instance].userPoint = (NSString *)[resultDic valueForKey:@"credit"];//积点
                                             [AppManager instance].userBonusNum = (NSString *)[resultDic valueForKey:@"couponCount"];//红包
                                             [AppManager instance].userAddressNum = (NSString *)[resultDic valueForKey:@"addressCount"];//地址数
                                             
                                             [self transStoreInfo];
                                         } else {
                                             
                                             [self showHUDWithText:[backDic valueForKey:@"msg"]];
                                         }
                                     }
                                 }
                             }];
     }];
}

#pragma mark 商户信息
- (void)transStoreInfo
{
    
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] init];
    [dataDict setObject:[AppManager instance].userTicket forKey:@"pk"];
    
    NSMutableDictionary *paramDict = [CommonUtils getParamDict:@"getShopListInfo"
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
                                             
                                             NSArray *resultArray = (NSArray *)[(NSArray *)[backDic valueForKey:@"result"] valueForKey:@"shopList"];
                                             
                                             NSInteger resultCount = [resultArray count];
                                             
                                             for (NSInteger i=0; i<resultCount; i++) {
                                                 
                                                 NSDictionary *resultDic = (NSDictionary *)resultArray[i];
                                                 
                                                 
                                                 StoreModel *storeModel = [[StoreModel alloc] initWithDict:resultDic];
                                                 
                                                  storeModel.storeId = (NSString *)[resultDic valueForKey:@"shopDetailId"];
                                                  storeModel.distance = (NSString *)[resultDic valueForKey:@"distance"];
                                                  storeModel.imageUrl = (NSString *)[resultDic valueForKey:@"picUrl"];
                                                  storeModel.address = (NSString *)[resultDic valueForKey:@"shopAddress"];
                                                  storeModel.brand = (NSString *)[resultDic valueForKey:@"shopBrands"];
                                                  storeModel.name = (NSString *)[resultDic valueForKey:@"shopName"];
                                                  storeModel.transpotation = (NSString *)[resultDic valueForKey:@"transpotation"];
                                                  
                                                  NSArray *typeArray = (NSArray *)[resultDic valueForKey:@"shopTypeList"];
                                                  storeModel.productTypeArray = typeArray;
                                                 
                                                 [storeArray addObject:storeModel];
                                             }
                                             
                                             [self.mTableView reloadData];
                                         } else {
                                             
                                             [self showHUDWithText:[backDic valueForKey:@"msg"]];
                                         }
                                     }
                                 }
                             }];
     }];
}

@end
