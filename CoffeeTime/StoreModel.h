//
//  StoreModel.h
//  CoffeeTime
//
//  Created by fule on 15/7/1.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreModel : NSObject

@property (strong, nonatomic) NSString *storeId;//id
@property (strong, nonatomic) NSString *imageUrl;//
@property (strong, nonatomic) NSString *address;//
@property (strong, nonatomic) NSString *brand;//
@property (strong, nonatomic) NSString *name;//
@property (strong, nonatomic) NSString *distance;//距离
@property (strong, nonatomic) NSString *transpotation;//运费

@property (strong, nonatomic) NSMutableArray *productTypeArray;//类型

-(instancetype)initWithDict:(NSDictionary *)dict;

@end
