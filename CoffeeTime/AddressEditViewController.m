//
//  AddressEditViewController.m
//  CoffeeTime
//
//  Created by Adam on 15/6/24.
//  Copyright (c) 2015年 Adam. All rights reserved.
//

#import "AddressEditViewController.h"

@interface AddressEditViewController () <UIActionSheetDelegate>

@property (nonatomic, copy) NSString *addressId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *address;

@end

@implementation AddressEditViewController

@synthesize addressId;
@synthesize name;
@synthesize phone;
@synthesize address;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.nameTxt.text = self.name;
    self.phoneTxt.text = self.phone;
    self.addressTxt.text = self.address;
    
    if (self.addressId != nil && ![self.addressId isEqualToString:@""]) {
        self.navigationItem.title = @"编辑地址";
    } else {
        self.navigationItem.title = @"新增地址";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doSave:(id)sender {
    
    [self transSaveAddress];
    
    [self showHUDWithText:@"保存数据"];
}

- (void)updateData:(NSString *)aAddressId name:(NSString *)aName phone:(NSString *)aPhone address:(NSString *)aAddress
{
    self.name = aName;
    self.phone = aPhone;
    self.address = aAddress;
    self.addressId = aAddressId;
}

#pragma mark - 交互
#pragma mark 用户登录
- (void)transSaveAddress
{
    
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] init];
    [dataDict setObject:self.nameTxt.text forKey:@"receiverName"];
    [dataDict setObject:self.phoneTxt.text forKey:@"receiverPhone"];
    [dataDict setObject:self.addressTxt.text forKey:@"receiverAddress"];
    
    NSString *cmdStr = @"addAddress";
    
    if (self.addressId != nil && ![self.addressId isEqualToString:@""]) {
        
        [dataDict setObject:self.addressId forKey:@"id"];
        cmdStr = @"updateAddress";
        
    } else {
        
        cmdStr = @"addAddress";
    }
    
    NSMutableDictionary *paramDict = [CommonUtils getParamDict:cmdStr
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
                                             
                                         } else {
                                             
                                             [self showHUDWithText:[backDic valueForKey:@"msg"]];
                                         }
                                     }
                                 }
                             }];
     }];
}

@end
