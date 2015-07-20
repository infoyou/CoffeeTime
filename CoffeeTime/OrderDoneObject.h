//
//  OrderDoneObject.h
//  CoffeeTime
//
//  Created by Dave on 15/7/20.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderDoneObject : NSObject

@property (nonatomic, strong) NSString *orderNumber;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, strong) NSString *imageUrl;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
