//
//  OrderDetailViewController.h
//  CoffeeTime
//
//  Created by fule on 15/6/29.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
@interface OrderDetailViewController :RootViewController

- (IBAction)confirmButton:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *mTableView;

@end
