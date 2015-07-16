//
//  ProductModel.m
//  CoffeeTime
//
//  Created by Adam on 15/7/1.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import "ProductModel.h"

@implementation ProductModel

-(instancetype)initWithDict:(NSDictionary *)dict typeArray:(NSMutableArray *)typeArray

{
    
    if (self = [super init])
        
    {
        
        self.productId = dict[@"commodityId"];
        self.productName = dict[@"commodityName"];
        self.imageUrl = dict[@"picUrl"];
        self.productKind = dict[@"commodityClass"];
        self.productNo = dict[@"commodityNumber"];
        
        self.productTypeArray = typeArray;
        
    }
    
    return  self;
    
}


@end
