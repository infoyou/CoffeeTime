//
//  ShopCarViewController.h
//  CoffeeTime
//
//  Created by Adam on 15/6/29.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
@interface ShopCarViewController : RootViewController
- (IBAction)confirmButton:(id)sender;
- (IBAction)xiuGaiButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *confirmView;
@property (strong, nonatomic) IBOutlet UITableView *mTableView;
@property (strong, nonatomic) IBOutlet UITextView *textView;

@end
