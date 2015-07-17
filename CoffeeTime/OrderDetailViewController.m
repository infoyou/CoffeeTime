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

@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"订单确认";
    
    [self.mTableView setBackgroundColor:COLOR(238, 237, 235)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideHUD) name:ORDER_PAY_NOTIFICATION object:nil];
    // Do any additional setup after loading the view from its nib.
    [self getTotalPrice];
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
    return 3;
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
    return 10.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 94;
    } else if (indexPath.section==1) {
        return 47;
    } else
        return 140;

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
            if (indexPath.row==0) {
                cell.chooseLabel.text=@"送达时间";
                cell.meansLabel.text=@"尽快送达";
            }else if (indexPath.row==1){
                cell.chooseLabel.text=@"支付方式";
                cell.meansLabel.text=@"微信支付";
            }else if (indexPath.row==2){
                cell.chooseLabel.text=@"使用红包";
                cell.meansLabel.text=@"星巴克满一杯减10元(7月27号到期)";
                cell.meansLabel.font=[UIFont fontWithName:@"Arial" size:12];
                cell.meansLabel.textColor=[UIColor redColor];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            return cell;
            
        }
            break;
            
        case 2:
        {
            static NSString *CellID = @"CellID";
            OrderFootTableViewCell *cell = [self.mTableView dequeueReusableCellWithIdentifier:CellID];
            
            if (cell==nil) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"OrderFootTableViewCell" owner:nil options:nil]lastObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            // Total Price
            cell.totalPriceLabel.text = [NSString stringWithFormat:@"￥%d", totalPrice];
            cell.currentPriceLabel.text = [NSString stringWithFormat:@"￥%d", totalPrice - 2];
            
            self.payPrice.text = [NSString stringWithFormat:@"￥%d", totalPrice - 2];
            
            return cell;
            
        }
            break;
            
        default:
            break;
    }
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        AddressListViewController*vc=[AddressListViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (IBAction)confirmButton:(id)sender {
    [[WXPayClient shareInstance] payProductwithPrice:@"250"];

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


@end
