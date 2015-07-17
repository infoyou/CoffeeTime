//
//  ShopCartTableCell.m
//  CoffeeTime
//
//  Created by Adam on 15/7/10.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import "ShopCartTableCell.h"

@implementation ShopCartTableCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/**
 *  给单元格赋值
 *
 *  @param productModel 里面存放各个控件需要的数值
 */
- (void)addProductUnit:(ShopCartModel *)shopCartModel indexPath:(NSIndexPath *)indexPath
{
    
    // Content
    // SKU Type
    NSInteger offsetY = 10;
    
    UILabel *typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(78, 20 + offsetY, 71, 20)];
    typeLabel.text = [NSString stringWithFormat:@"%@", shopCartModel.unitName];
    typeLabel.textAlignment = NSTextAlignmentCenter;
    [typeLabel setFont:[UIFont fontWithName:@"Arial" size:14]];
    [self addSubview:typeLabel];
    
    // Price
    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(147, 20 + offsetY, 54, 20)];
    priceLabel.text = [NSString stringWithFormat:@"￥%d", [shopCartModel.unitPrice integerValue]/100];
    priceLabel.textAlignment = NSTextAlignmentCenter;
    [priceLabel setFont:[UIFont fontWithName:@"Arial" size:14]];
    [self addSubview:priceLabel];
    
    UILabel *numLabel = [[UILabel alloc]initWithFrame:CGRectMake(250, 20 + offsetY - 3, 25, 25)];
    numLabel.text = [NSString stringWithFormat:@"%@", shopCartModel.shopCartNum];
    numLabel.textAlignment = NSTextAlignmentCenter;
    [numLabel setFont:[UIFont fontWithName:@"Arial" size:14]];
    [self addSubview:numLabel];
    
    // Sub button
    UIButton *subButton=[UIButton buttonWithType:UIButtonTypeCustom];
    subButton.frame = CGRectMake(225, 20 + offsetY - 3, 25, 25);
    subButton.layer.cornerRadius = 12.5;
    subButton.layer.masksToBounds = YES;
    
    [subButton setImage:[UIImage imageNamed:@"btn_reduce.png"] forState:UIControlStateNormal];
    subButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    subButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:16];
    [subButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    subButton.tag = 10000*indexPath.row + 10;
    [subButton addTarget:self action:@selector(subButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:subButton];
    
    // Add button
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(275, 20 + offsetY - 3, 25, 25);
    addButton.layer.cornerRadius = 12.5;
    addButton.layer.masksToBounds = YES;
    [addButton setImage:[UIImage imageNamed:@"btn_add.png"] forState:UIControlStateNormal];
    
    addButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    addButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:16];
    [addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    addButton.tag = 10000*indexPath.row + 11;
    [addButton addTarget:self action:@selector(addButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addButton];
    
    self.productNameLabel.text = shopCartModel.productName;
}

- (void)addButton:(UIButton*)btn
{
    
    [self.delegate btnClick:self tag:(NSInteger)btn.tag];
}

- (void)subButton:(UIButton*)btn
{
    
    [self.delegate btnClick:self tag:(NSInteger)btn.tag];
}

@end
