//
//  GoodsModel.m
//  CoffeeTime
//
//  Created by fule on 15/7/1.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import "GoodsModel.h"

@implementation GoodsModel
-(instancetype)initWithDict:(NSDictionary *)dict

{
    
    if (self = [super init])
        
    {
        
        self.imageName = dict[@"imageName"];
        
        self.goodsTitle = dict[@"goodsTitle"];
        
        self.goodsArray = dict[@"goodsArray"];
        
    }
    
    return  self;
    
}


@end
