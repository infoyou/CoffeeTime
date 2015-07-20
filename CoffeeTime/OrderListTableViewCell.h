//
//  OrderListTableViewCell.h
//  CoffeeTime
//
//  Created by Adam on 15/7/7.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *storeIcon;
@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UILabel *orderPrice;
@property (weak, nonatomic) IBOutlet UILabel *createTime;

@end
