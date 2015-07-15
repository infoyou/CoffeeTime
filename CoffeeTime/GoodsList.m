//
//  GoodsList.m
//  CoffeeTime
//
//  Created by fule on 15/7/1.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import "GoodsList.h"

@implementation GoodsList
-(instancetype)initWithDict:(NSDictionary *)dict

{
    
    if (self = [super init])
        
    {
        self.goodsPrice=dict[@"goodsPrice"];
        self.goodsSharp = dict[@"goodsSharp"];
        self.goodsNum = [dict[@"goodsNum"]intValue];
        
    }
    
    return  self;
    
}
//
//-(NSString*)description{
//    return [NSString stringWithFormat:@"%@--%@--%d",self.goodsPrice,self.goodsSharp,self.goodsNum];
//}
@end
