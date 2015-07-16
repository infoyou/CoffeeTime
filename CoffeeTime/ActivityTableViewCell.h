//
//  ActivityTableViewCell.h
//  CoffeeTime
//
//  Created by Adam on 15/7/7.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityModel.h"

@protocol ActivityTableViewCellDelete <NSObject>

- (void)btnClick:(UITableViewCell *)cell andFlag:(NSInteger)flag;

@end

@interface ActivityTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UIButton *addBtn;
@property (strong, nonatomic) IBOutlet UIButton *subBtn;
@property (strong, nonatomic) IBOutlet UILabel *countLabel;

@property (assign,nonatomic) id<ActivityTableViewCellDelete> delegate;

-(void)addTheValue:(ActivityModel *)activiyModel indexPath:(NSIndexPath*)indexPath;

@end
