//
//  ProductTableViewCell.h
//  CoffeeTime
//
//  Created by Adam on 15/6/30.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"
#import "ProductTypeModel.h"

@protocol ProductTableViewCellDelegate <NSObject>

-(void)btnClick:(UITableViewCell *)cell andFlag:(NSInteger)flag;
@end

@interface ProductTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *goodsTitle;
@property (strong, nonatomic) IBOutlet UIImageView *goodsImage;
@property (strong, nonatomic) IBOutlet UIButton *addButton;
@property (strong, nonatomic) IBOutlet UIButton *subButton;
@property (strong, nonatomic) IBOutlet UILabel *unitPrice;
@property (strong, nonatomic) IBOutlet UILabel *goodNum;

- (IBAction)addButton:(id)sender;
- (IBAction)subButton:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *unitName;

@property (assign,nonatomic) id<ProductTableViewCellDelegate> delegate;

-(void)addTheValue:(ProductModel *)goodsModel theValue:(ProductTypeModel*)goodList indexPath:(NSIndexPath *)indexPath;

@end
