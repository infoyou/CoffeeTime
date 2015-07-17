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

- (void)btnClick:(UITableViewCell *)cell tag:(NSInteger)tag;

@end

@interface ProductTableViewCell : UITableViewCell

@property (assign, nonatomic) id<ProductTableViewCellDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *productName;
@property (strong, nonatomic) IBOutlet UIImageView *productIcon;


- (void)addProductUnit:(ProductModel *)productModel indexPath:(NSIndexPath *)indexPath;

@end
