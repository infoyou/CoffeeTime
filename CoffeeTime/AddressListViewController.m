//
//  AddressListViewController.m
//  CoffeeTime
//
//  Created by Adam on 15/6/24.
//  Copyright (c) 2015年 Adam. All rights reserved.
//

#import "AddressListViewController.h"
#import "AddressEditViewController.h"
#import "AddressModel.h"
@interface AddressListViewController () <UIActionSheetDelegate>
{
    NSMutableArray *infoArr;
    
}
@end

@implementation AddressListViewController

@synthesize addAddressView;

NSInteger selIndex;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"选择地址";
    
    selIndex = 1;
    
    // Do any additional setup after loading the view from its nib.
    [self.mTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    [self.mTableView setBackgroundColor:COLOR(238, 237, 235)];
    
    [self.addAddressView setFrame:CGRectMake(self.addAddressView.frame.origin.x, self.view.frame.size.height - self.addAddressView.frame.size.height-64, SCREEN_WIDTH, self.addAddressView.frame.size.height)];
    
    [self addTapGestureRecognizer:self.addAddressView];
    
    [self transUserAddress];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden=NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView的协议方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [infoArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellID = @"CellID";
    UITableViewCell *cell = [self.mTableView dequeueReusableCellWithIdentifier:CellID];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"AddressListCellView" owner:nil options:nil] lastObject];
    }
    
    AddressModel *addressModel = (AddressModel *)infoArr[indexPath.row];
    UIImageView *addressImageView = (UIImageView *)[cell viewWithTag:10];
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:11];
    UILabel *phoneLabel = (UILabel *)[cell viewWithTag:12];
    UILabel *addressLabel = (UILabel *)[cell viewWithTag:13];
    
    UIButton *btnBuy = (UIButton *)[cell viewWithTag:20];
    btnBuy.layer.cornerRadius = 4;
    btnBuy.layer.masksToBounds = YES;
    [btnBuy addTarget:self action:@selector(doAddressEdit:event:) forControlEvents:UIControlEventTouchUpInside];
    
    nameLabel.text=addressModel.receiverName;
    phoneLabel.text=addressModel.receiverPhone;
    addressLabel.text=addressModel.receiverAddress;
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row != selIndex) {
        addressImageView.image = [UIImage imageNamed:@"address.png"];
    } else {
        addressImageView.image = [UIImage imageNamed:@"address_sel.png"];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    selIndex = indexPath.row;
    
    [self showHUDWithText:@"默认地址更改成功!"];
    
    [self.mTableView reloadData];
}

- (void)imageviewTouchEvents:(UIGestureRecognizer *)gestureRecognizer
{
    UIView *view = (UIView*)[gestureRecognizer view];
    int viewTag = view.tag;
    
    DLog(@"%d is touched",viewTag);
    
    AddressEditViewController *addEditVC = [[AddressEditViewController alloc] init];
    
    [self.navigationController pushViewController:addEditVC animated:YES];
}

#pragma mark 地址列表
- (void)transUserAddress
{
    infoArr = [[NSMutableArray alloc]init];
    
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] init];
    
    NSMutableDictionary *paramDict = [CommonUtils getParamDict:@"addressList"
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
                                                 
                                                 AddressModel *addressModel = [[AddressModel alloc] initWithDict:resultDic];
                                                 [infoArr addObject:addressModel];
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

- (void)doAddressEdit:(id)sender event:(id)event
{

    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.mTableView];
    
    NSIndexPath *indexPath = [self.mTableView indexPathForRowAtPoint:currentTouchPosition];
    if (indexPath != nil)
    {
        AddressModel *addressModel = (AddressModel *)infoArr[indexPath.row];
        
        AddressEditViewController *addEditVC = [[AddressEditViewController alloc] init];
        
        [addEditVC updateData:addressModel.addressId
                         name:addressModel.receiverName
                        phone:addressModel.receiverPhone
                      address:addressModel.receiverAddress];
        
        [self.navigationController pushViewController:addEditVC
                                             animated:YES];
    }
    
}

@end
