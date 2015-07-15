//
//  ActivityViewController.h
//  CoffeeTime
//
//  Created by fule on 15/6/24.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "RootViewController.h"

@interface ActivityViewController : RootViewController

@property (strong, nonatomic) IBOutlet UIView *navView;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@property (weak, nonatomic) IBOutlet UIView *totalPriceView;
@property (strong, nonatomic) IBOutlet UILabel *allPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *btnDone;

@end
