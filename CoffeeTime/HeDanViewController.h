//
//  HeDanViewController.h
//  CoffeeTime
//
//  Created by Adam on 15/7/7.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface HeDanViewController : RootViewController

@property (strong, nonatomic) IBOutlet UIView *navView;
@property (strong, nonatomic) IBOutlet UITableView *mTableView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segMent;
- (IBAction)segChange:(id)sender;

@end
