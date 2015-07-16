//
//  ProductTableViewCell.m
//  CoffeeTime
//
//  Created by Adam on 15/6/30.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import "ProductTableViewCell.h"
#import "ProductModel.h"
#import "ProductTypeModel.h"
#import "UIImageView+WebCache.h"

@implementation ProductTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
        
    {
        
        
    }
    
    return self;
    
}

/**
 *  给单元格赋值
 *
 *  @param productModel 里面存放各个控件需要的数值
 */
-(void)addTheValue:(ProductModel *)productModel theValue:(ProductTypeModel *)productTypeModel indexPath:(NSIndexPath *)indexPath
{

    // Icon
    [self.goodsImage sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:productModel.imageUrl] andPlaceholderImage:[UIImage imageNamed:@"productPlaceHold.png"] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        //Nothing.
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //Nothing.
        self.goodsImage.image = image;
    }];
    
    // Content
    for (int goodsTypeListIndex=0; goodsTypeListIndex<productModel.productTypeArray.count; goodsTypeListIndex++) {
        
       // NSLog(@"%@",[productModel.productTypeArray[0] description]);
        
        ProductTypeModel* productTypeModel = productModel.productTypeArray[goodsTypeListIndex];
        
        // SKU Type
        UILabel*sharpLabel = [[UILabel alloc]initWithFrame:CGRectMake(98, 20+30*(goodsTypeListIndex+1), 41, 20)];
        sharpLabel.text = [NSString stringWithFormat:@"%@", productTypeModel.unitName];
        sharpLabel.textAlignment=NSTextAlignmentCenter;
        [sharpLabel setFont:[UIFont fontWithName:@"Arial" size:14]];
        [self addSubview:sharpLabel];
        
        // Price
        UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(147, 20+30*(goodsTypeListIndex+1), 54, 20)];
        priceLabel.text = [NSString stringWithFormat:@"￥%@", productTypeModel.unitPrice];
        priceLabel.textAlignment = NSTextAlignmentCenter;
        [priceLabel setFont:[UIFont fontWithName:@"Arial" size:14]];
        [self addSubview:priceLabel];
        
        UILabel *numLabel = [[UILabel alloc]initWithFrame:CGRectMake(250, 20 + 30 * (goodsTypeListIndex+1) - 3, 25, 25)];
        numLabel.text = [NSString stringWithFormat:@"%d", productTypeModel.productNum];
        numLabel.textAlignment = NSTextAlignmentCenter;
        [numLabel setFont:[UIFont fontWithName:@"Arial" size:14]];
        [self addSubview:numLabel];
        
        // Sub button
        UIButton *subButton=[UIButton buttonWithType:UIButtonTypeCustom];
        subButton.frame=CGRectMake(225, 20 + 30*(goodsTypeListIndex+1) - 3, 25, 25);
        subButton.layer.cornerRadius=12.5;
        subButton.layer.masksToBounds=YES;
        
        [subButton setImage:[UIImage imageNamed:@"btn_reduce.png"] forState:UIControlStateNormal];
        subButton.titleLabel.textAlignment=NSTextAlignmentCenter;
        subButton.titleLabel.font=[UIFont fontWithName:@"Arial" size:16];
        [subButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        subButton.tag=10000*indexPath.row + (goodsTypeListIndex * 10 + 10);
        [subButton addTarget:self action:@selector(subButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:subButton];

        // Add button
        UIButton*addButton=[UIButton buttonWithType:UIButtonTypeCustom];
        addButton.frame=CGRectMake(275, 20 + 30 *(goodsTypeListIndex+1)- 3, 25, 25);
        addButton.layer.cornerRadius=12.5;
        addButton.layer.masksToBounds=YES;
        [addButton setImage:[UIImage imageNamed:@"btn_add.png"] forState:UIControlStateNormal];
        
        addButton.titleLabel.textAlignment=NSTextAlignmentCenter;
        addButton.titleLabel.font=[UIFont fontWithName:@"Arial" size:16];
        [addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        addButton.tag=10000*indexPath.row + (goodsTypeListIndex * 10 + 11);
        [addButton addTarget:self action:@selector(addButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:addButton];
        
    }
    
    self.goodsTitle.text = productModel.productName;
    
}

-(void)addButton:(UIButton*)btn{
   
    [self.delegate btnClick:self andFlag:(NSInteger)btn.tag];

}
-(void)subButton:(UIButton*)btn{
   
    [self.delegate btnClick:self andFlag:(NSInteger)btn.tag];

}

@end
