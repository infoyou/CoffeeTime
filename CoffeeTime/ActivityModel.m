//
//  ActivityModel.m
//  CoffeeTime
//
//  Created by fule on 15/7/13.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import "ActivityModel.h"

@implementation ActivityModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    
    if (self = [super init])
        
    {
        
        self.activiyName = dict[@"activiyName"];
        
        self.activiyPrice = [dict[@"activiyPrice"]integerValue];
        
        self.num=[dict[@"num"]integerValue];
    }
    
    return  self;
    
}

@end
