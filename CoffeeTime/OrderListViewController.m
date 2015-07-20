//
//  OrderListViewController.m
//  CoffeeTime
//
//  Created by Adam on 15/7/7.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import "OrderListViewController.h"
#import "OrderListTableViewCell.h"
#import "Header.h"
#import "OrderDoneObject.h"

@interface OrderListViewController ()

@property (nonatomic, strong) NSMutableArray *infoArr;
@end

@implementation OrderListViewController

@synthesize infoArr;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navView.backgroundColor=barColor;
    self.navigationController.navigationBarHidden=YES;

    // Tab Bar
    [self showOrHideTabBar:NO];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)adjustView
{
    
}

- (void)initData
{

    [self transOrderList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView的协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.segMent.selectedSegmentIndex==0) {
        return 1;
    } else {
        return 3;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.segMent.selectedSegmentIndex == 0) {
        static NSString *CellID = @"CellID";
        UITableViewCell *cell = [self.mTableView dequeueReusableCellWithIdentifier:CellID];
        if (cell == nil) {
            //cell = [[[NSBundle mainBundle]loadNibNamed:@"ActivityTableViewCell" owner:nil options:nil]lastObject];
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
            
        }
        cell.textLabel.text=@"星巴克拿铁咖啡(中)×1";
        cell.textLabel.font=[UIFont fontWithName:@"Arial" size:13];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    } else {
        
        static NSString *CellID2 = @"CellID2";
        OrderListTableViewCell *cell = [self.mTableView dequeueReusableCellWithIdentifier:CellID2];
        
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"OrderListTableViewCell" owner:nil options:nil] lastObject];
        }
        
        OrderDoneObject *orderDoneObject = (OrderDoneObject *)[infoArr objectAtIndex:indexPath.row];
        cell.storeName.text = orderDoneObject.shopName;
        cell.createTime.text = orderDoneObject.createTime;
        cell.orderPrice.text = orderDoneObject.money;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    
    }
    
    return nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.segMent.selectedSegmentIndex==0) {
        return 20;
    } else {
        return 76;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.segMent.selectedSegmentIndex==0) {
        return 25;
    }else{
        return 0.1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.segMent.selectedSegmentIndex==0) {
        return 220;
    }else{
        return 0.01;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.segMent.selectedSegmentIndex==0) {
        UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
        UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, 180, 20)];
        label.text=@"订单编号:154856541546";
        label.font=[UIFont fontWithName:@"Arial" size:13];
        [view addSubview:label];
        
        UILabel*label2=[[UILabel alloc]initWithFrame:CGRectMake(230, 0, 80, 25)];
        label2.text=@"正在配送";
        [label2 setTextColor:[UIColor redColor]];
        label2.font=[UIFont fontWithName:@"Arial" size:18];
        [view addSubview:label2];
        return view;

    }else{
    
        return nil;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (self.segMent.selectedSegmentIndex==0) {
//        [testBtn.layer setMasksToBounds:YES];
//        [testBtn.layer setCornerRadius:8.0]; //设置矩圆角半径
//        [testBtn.layer setBorderWidth:1.0];   //边框宽度
//        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 1, 0, 0, 1 });
//        [testBtn.layer setBorderColor:colorref];//边框颜色
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"HeDanFootView" owner:self options:nil];
        UIView *footView = [nib objectAtIndex:0];
        footView.frame=CGRectMake(0, 0, 320, 220);
        UIButton*lianXiButton=(UIButton*)[footView viewWithTag:100];
        //lianXiButton.backgroundColor = [UIColor redColor];
        lianXiButton.layer.masksToBounds=YES;
        lianXiButton.layer.cornerRadius=4;
        lianXiButton.layer.borderColor=[[UIColor blackColor]CGColor];
        lianXiButton.layer.borderWidth=1;
        
        UIButton*cuiDanButton=(UIButton*)[footView viewWithTag:200];
        //lianXiButton.backgroundColor=[UIColor redColor];
        cuiDanButton.layer.masksToBounds=YES;
        cuiDanButton.layer.cornerRadius=4;
        cuiDanButton.layer.borderColor=[[UIColor blackColor]CGColor];
        cuiDanButton.layer.borderWidth=1;
        
        return footView;
    } else {
    
        return nil;
    }
}

- (IBAction)segChange:(id)sender {
    [self.mTableView reloadData];
}

#pragma mark 订单列表
- (void)transOrderList
{
    infoArr = [[NSMutableArray alloc]init];
    
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] init];
    
    NSMutableDictionary *paramDict = [CommonUtils getParamDict:@"orderList"
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
                                             
                                             NSArray *resultArray = (NSArray *)[backDic valueForKey:@"result"];
                                             NSInteger resultArrayCount = [resultArray count];
                                             
                                             for (NSInteger i=0; i<resultArrayCount; i++) {
                                                 NSDictionary *resultDic = (NSDictionary *)resultArray[i];
                                                 
                                                 /*
                                                  "orderNumber": "123456",
                                                  "createTime": "2015-07-07 14:34:36",
                                                  "money": "20",
                                                  "shopName": "星巴克",
                                                  "picUrl": "http://happyo2o.cn/HappyHour/resources/project_image/1/201507131111110.png"
                                                  */
                                                 
                                                 
                                                 OrderDoneObject *orderObject = [[OrderDoneObject alloc] initWithDict:resultDic];
                                                 [infoArr addObject:orderObject];
                                                 [self.mTableView reloadData];
                                             }
                                         } else {
                                             
                                             [self showHUDWithText:[backDic valueForKey:@"msg"]];
                                         }
                                     }
                                 }
                             }];
     }];
}

@end
