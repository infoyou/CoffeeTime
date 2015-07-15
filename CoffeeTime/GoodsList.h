//
//  GoodsList.h
//  CoffeeTime
//
//  Created by fule on 15/7/1.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsList : NSObject

@property(strong,nonatomic)NSString *goodsPrice;//商品单价
@property(strong,nonatomic)NSString *goodsSharp;//商品尺寸
@property(assign,nonatomic)NSInteger goodsNum;//商品个数

-(instancetype)initWithDict:(NSDictionary *)dict;

@end
