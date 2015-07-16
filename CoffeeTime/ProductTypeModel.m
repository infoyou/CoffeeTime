//
//  ProductTypeModel.m
//  CoffeeTime
//
//  Created by Adam on 15/7/1.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import "ProductTypeModel.h"

@implementation ProductTypeModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    
    if (self = [super init])
    {
        self.unitId = dict[@"typeId"];
        self.unitName = dict[@"type"];
        self.unitPrice = @([dict[@"price"] integerValue]);
        self.productNum = [dict[@"productNum"] integerValue];
    }
    
    return  self;
}

@end
