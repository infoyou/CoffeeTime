//
//  AddressListViewController.h
//  CoffeeTime
//
//  Created by Adam on 15/6/24.
//  Copyright (c) 2015年 Adam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface AddressListViewController : RootViewController


@property (strong, nonatomic) IBOutlet UITableView *mTableView;
@property (weak, nonatomic) IBOutlet UIView *addAddressView;

@end
