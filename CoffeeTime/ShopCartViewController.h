//
//  ShopCartViewController.h
//  CoffeeTime
//
//  Created by Adam on 15/6/29.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface ShopCartViewController : RootViewController

@property (strong, nonatomic) IBOutlet UIView *confirmView;
@property (strong, nonatomic) IBOutlet UITableView *mTableView;
@property (strong, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UIButton *btnSwitchProduct;
@property (weak, nonatomic) IBOutlet UIButton *btnConfim;

- (IBAction)doSwitchProduct:(id)sender;
- (IBAction)doConfim:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;

@end
