//
//  OrderFootTableViewCell.h
//  CoffeeTime
//
//  Created by Adam on 15/7/10.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderFootTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;

@end
