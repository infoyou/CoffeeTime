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
        self.unitPrice = [NSString stringWithFormat:@"￥%@", dict[@"price"]];
        self.unitName = dict[@"type"];
        self.productNum = @([dict[@"productNum"] integerValue]);
    }
    
    return  self;
}

//
//-(NSString*)description{
//    return [NSString stringWithFormat:@"%@--%@--%d",self.unitPrice,self.unitName,self.productNum];
//}

@end
