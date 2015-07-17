//
//  ShopCartTableCell.h
//  CoffeeTime
//
//  Created by Adam on 15/7/10.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCartModel.h"

@protocol ShopCartTableCellDelegate <NSObject>

- (void)btnClick:(UITableViewCell *)cell tag:(NSInteger)tag;

@end

@interface ShopCartTableCell : UITableViewCell

@property (assign, nonatomic) id<ShopCartTableCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *unitNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *unitPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopCartNumLabel;

- (void)addProductUnit:(ShopCartModel *)shopCartModel indexPath:(NSIndexPath *)indexPath;

@end
