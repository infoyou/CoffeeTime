//
//  AddressEditViewController.h
//  CoffeeTime
//
//  Created by Adam on 15/6/24.
//  Copyright (c) 2015年 Adam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface AddressEditViewController : RootViewController

- (void)updateData:(NSString *)name phone:(NSString *)phone address:(NSString *)address;

@property (weak, nonatomic) IBOutlet UITextField *nameTxt;
@property (weak, nonatomic) IBOutlet UITextField *phoneTxt;
@property (weak, nonatomic) IBOutlet UITextView *addressTxt;

@end
