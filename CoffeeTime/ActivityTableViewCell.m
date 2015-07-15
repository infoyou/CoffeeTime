//
//  ActivityTableViewCell.m
//  CoffeeTime
//
//  Created by fule on 15/7/7.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import "ActivityTableViewCell.h"
#import "ActivityModel.h"
@implementation ActivityTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)addTheValue:(ActivityModel *)activiyModel indexPath:(NSIndexPath *)indexPath{
    
    self.priceLabel.text=[NSString stringWithFormat:@"￥%d",activiyModel.activiyPrice];
    self.nameLabel.text=activiyModel.activiyName;
    self.countLabel.text=[NSString stringWithFormat:@"%d",activiyModel.num];
    self.addBtn.tag=indexPath.row+10;
    [self.addBtn addTarget:self action:@selector(addButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.subBtn.tag=indexPath.row+20;
    [self.subBtn addTarget:self action:@selector(subButton:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)addButton:(UIButton*)btn{
    
    [self.delegate btnClick:self andFlag:(int)btn.tag];
    
}
-(void)subButton:(UIButton*)btn{
    
    [self.delegate btnClick:self andFlag:(int)btn.tag];
    
}

@end
