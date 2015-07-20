//
//  ShopCartModel.m
//  CoffeeTime
//
//  Created by Adam on 15/7/15.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import "ShopCartModel.h"

@implementation ShopCartModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    
    if (self = [super init])
    {
//        @property(strong,nonatomic)NSString *shopName;//商店名称
//        @property(strong,nonatomic)NSString *shopId;//商店ID
//        @property(strong,nonatomic)NSString *commodityId;//商品ID
//        @property(strong,nonatomic)NSString *commodityTypeId;//商品属性ID
//        @property(strong,nonatomic)NSString *commodityNumber;//商品编码
//        @property(strong,nonatomic)NSString *commodityPrice;//商品单价
//        @property(assign,nonatomic)NSInteger typeId;//商品TypeId
//        @property(assign,nonatomic)NSInteger num;//商品个数
        
        self.shopName = dict[@"shopName"];
        self.shopId = dict[@"shopId"];
        self.productId = dict[@"commodityId"];
        self.productName = dict[@"commodityName"];
        self.unitId = dict[@"commodityTypeId"];
        self.unitPrice = @([dict[@"commodityPrice"] integerValue] * 100);
        self.productNo = dict[@"commodityNumber"];
        self.unitName = dict[@"commodityTypeName"];
        self.shopCartNum = dict[@"commodityAmount"];
    }
    
    return self;
}

@end
