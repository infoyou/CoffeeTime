//
//  OrderDoneObject.m
//  CoffeeTime
//
//  Created by Dave on 15/7/20.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import "OrderDoneObject.h"

@implementation OrderDoneObject

- (instancetype)initWithDict:(NSDictionary *)dict
{
    
    if (self = [super init])
    {        
        self.orderNumber = dict[@"orderNumber"];
        self.createTime = dict[@"createTime"];
        self.money = dict[@"money"];
        self.shopName = dict[@"shopName"];
        self.imageUrl = dict[@"picUrl"];
    }
    
    return self;
}

@end
