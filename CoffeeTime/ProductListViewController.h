//
//  ProductListViewController.h
//  CoffeeTime
//
//  Created by fule on 15/6/25.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface ProductListViewController : RootViewController

@property (strong, nonatomic) IBOutlet UIView *navView;

@property (strong, nonatomic) IBOutlet UITableView *mTableView;

- (IBAction)backButton:(id)sender;
- (IBAction)jieSuan:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UIView *confirmView;

@end
