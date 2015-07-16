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
@property (strong, nonatomic) NSString *unitName;//商品类型名称
@property (strong, nonatomic) NSNumber *unitPrice;//商品单价
@property (assign, nonatomic) NSInteger productNum;//商品个数

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
