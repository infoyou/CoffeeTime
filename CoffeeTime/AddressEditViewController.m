//
//  AddressEditViewController.m
//  CoffeeTime
//
//  Created by Adam on 15/6/24.
//  Copyright (c) 2015年 Adam. All rights reserved.
//

#import "AddressEditViewController.h"

@interface AddressEditViewController () <UIActionSheetDelegate>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *address;

@end

@implementation AddressEditViewController

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
    
    if (self.name != nil && ![self.name isEqualToString:@""]) {
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
    
    [self showHUDWithText:@"保存数据"];
}

- (void)updateData:(NSString *)aName phone:(NSString *)aPhone address:(NSString *)aAddress
{
    self.name = aName;
    self.phone = aPhone;
    self.address = aAddress;
}

@end
