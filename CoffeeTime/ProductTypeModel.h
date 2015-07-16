//
//  ProductTypeModel.h
//  CoffeeTime
//
//  Created by Adam on 15/7/1.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductTypeModel : NSObject

@property (strong, nonatomic) NSString *unitId;
@property (strong, nonatomic) NSString *unitPrice;//商品单价
@property (strong, nonatomic) NSString *unitName;//商品类型名称
@property (assign, nonatomic) NSNumber *productNum;//商品个数

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
