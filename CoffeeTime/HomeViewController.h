//
//  HomeViewController.h
//  CoffeeTime
//
//  Created by fule on 15/6/24.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface HomeViewController : RootViewController

//@property (strong, nonatomic) IBOutlet UIView *bannerView;
@property (strong, nonatomic) IBOutlet UITableView *mTableView;

@property (weak, nonatomic) IBOutlet UILabel *locationTxt;

@end
