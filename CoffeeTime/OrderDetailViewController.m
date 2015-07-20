//
//  OrderDetailViewController.m
//  CoffeeTime
//
//  Created by Adam on 15/6/29.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderTableViewCell.h"
#import "OrderAddressTableViewCell.h"
#import "OrderFootTableViewCell.h"
#import "AddressListViewController.h"
#import "CommonUtil.h"
#import "WXApi.h"
#import "AFNetworking.h"
#import "WXPayClient.h"
#import "Header.h"

@interface OrderDetailViewController ()
{
NSInteger totalPrice;
}

@property (nonatomic, copy) NSString *orderNo;

@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"订单确认";
    
    [self.mTableView setBackgroundColor:COLOR(238, 237, 235)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideHUD) name:ORDER_PAY_NOTIFICATION object:nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)adjustView
{
    [self getTotalPrice];
    
    // Confim
    self.btnConfim.layer.cornerRadius = 4;
    self.btnConfim.layer.masksToBounds = YES;
    
    
    NSArray *nib2 = [[NSBundle mainBundle] loadNibNamed:@"OrderFootTableViewCell" owner:self options:nil];
    OrderFootTableViewCell *footView = [nib2 objectAtIndex:0];
    self.mTableView.tableFooterView = footView;
    
    // Total Price
    footView.totalPriceLabel.text = [NSString stringWithFormat:@"￥%d", totalPrice];
    footView.currentPriceLabel.text = [NSString stringWithFormat:@"￥%d", totalPrice - 2];

    self.payPrice.text = [NSString stringWithFormat:@"￥%d", totalPrice - 2];
}

- (void)hideHUD
{
    NSLog(@"支付成功，通知服务器");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView的协议方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(section == 1){
        
        return 3;
    } else {
        
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 14.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 94;
    } else if (indexPath.section == 1) {
        return 47;
    }
    
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    switch (indexPath.section) {
        case 0:
        {
            static NSString *CellID = @"CellID";
            OrderAddressTableViewCell *cell = [self.mTableView dequeueReusableCellWithIdentifier:CellID];
            
            if (cell==nil) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"OrderAddressTableViewCell" owner:nil options:nil]lastObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            return cell;
        }
            break;
            
        case 1:
        {
            static NSString *CellID = @"CellID";
            OrderTableViewCell *cell = [self.mTableView dequeueReusableCellWithIdentifier:CellID];
            
            if (cell==nil) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"OrderTableViewCell" owner:nil options:nil]lastObject];
            }
            if (indexPath.row == 0) {
                cell.chooseLabel.text = @"送达时间";
                cell.meansLabel.text = @"尽快送达";
            } else if (indexPath.row == 1) {
                cell.chooseLabel.text = @"支付方式";
                cell.meansLabel.text = @"微信支付";
            } else if (indexPath.row == 2) {
                cell.chooseLabel.text = @"使用红包";
                cell.meansLabel.text = @"星巴克满一杯减10元(7月27号到期)";
                cell.meansLabel.font = [UIFont fontWithName:@"Arial" size:12];
                cell.meansLabel.textColor = [UIColor redColor];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            return cell;
            
        }
            break;
            
        default:
            break;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0) {
        
        AddressListViewController *vc = [AddressListViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (IBAction)confirmButton:(id)sender {
    
    [self transOrderInfo];
}

- (void)getTotalPrice
{
    // Total Price
    NSMutableArray *shopCartShowNumber = [[FMDBConnection instance] getShopCartShowNumber:[AppManager instance].selStoreId];
    
    if ([shopCartShowNumber count] > 0) {
        
        totalPrice = [shopCartShowNumber[1] integerValue];

    } else {
        
        totalPrice = 0;
    }
    
}

#pragma mark 确认订单
- (void)transOrderInfo
{
    
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] init];
    [dataDict setObject:@"Adam" forKey:@"recieverName"];
    [dataDict setObject:@"13524010590" forKey:@"recieverPhone"];
    [dataDict setObject:@"黄陂南路751号" forKey:@"recieverAddress"];
    [dataDict setObject:@"立即送达" forKey:@"transportTime"];
    [dataDict setObject:@"2" forKey:@"payType"]; // 支付类型0：货到付款 1：支付宝 2:微信
    [dataDict setObject:@"13524010590" forKey:@"couponId"]; // 红包id
    [dataDict setObject:@"13524010590" forKey:@"activityId"]; // 活动id
    [dataDict setObject:@"13524010590" forKey:@"transpotation"]; // 运费
    [dataDict setObject:@(totalPrice - 2) forKey:@"total"]; // 总价
    [dataDict setObject:@"备注" forKey:@"remark"]; // 备注
    
    [dataDict setObject:[AppManager instance].selStoreId forKey:@"shopId"]; // 商铺id
    
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
    
    NSMutableDictionary *paramDict = [CommonUtils getParamDict:@"affirmOrder"
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
                                             NSString *orderNo = (NSString *)[[backDic valueForKey:@"result"] valueForKey:@"orderNumber"];
                                             
                                             [[WXPayClient shareInstance] payProductwithName:[NSString stringWithFormat:@"订单%@", orderNo] aPrice:[NSString stringWithFormat:@"%d", (totalPrice - 2) * 100]];
                                         } else {
                                             
                                             [self showHUDWithText:[backDic valueForKey:@"msg"]];
                                         }
                                     }
                                 }
                             }];
     }];
}

@end
