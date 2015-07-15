//
//  AddressModel.h
//  CoffeeTime
//
//  Created by fule on 15/7/14.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject

@property(strong,nonatomic) NSString *addressId;//商品图片

@property(strong,nonatomic) NSString *userName;//商品标题

@property(strong,nonatomic) NSString *receiverName;

@property(strong,nonatomic) NSString *receiverPhone;

@property(strong,nonatomic) NSString *receiverAddress;

@property(strong,nonatomic) NSString *isdefault;


- (instancetype)initWithDict:(NSDictionary *)dict;

@end
