//
//  ProductTableViewCell.h
//  CoffeeTime
//
//  Created by fule on 15/6/30.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"
#import "GoodsList.h"
@protocol shangPinTableViewCellDelegate <NSObject>

-(void)btnClick:(UITableViewCell *)cell andFlag:(int)flag;
@end

@interface ProductTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *goodsTitle;
@property (strong, nonatomic) IBOutlet UIImageView *goodsImage;
@property (strong, nonatomic) IBOutlet UIButton *addButton;
@property (strong, nonatomic) IBOutlet UIButton *subButton;
@property (strong, nonatomic) IBOutlet UILabel *goodsPrice;
@property (strong, nonatomic) IBOutlet UILabel *goodNum;
- (IBAction)addButton:(id)sender;
- (IBAction)subButton:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *goodsSharp;

@property(assign,nonatomic)id<shangPinTableViewCellDelegate>delegate;
-(void)addTheValue:(GoodsModel *)goodsModel theValue:(GoodsList*)goodList indexPath:(NSIndexPath *)indexPath;

@end
