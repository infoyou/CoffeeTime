//
//  ActivityModel.h
//  CoffeeTime
//
//  Created by fule on 15/7/13.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityModel : NSObject

@property(nonatomic,copy)NSString*activiyName;
@property(assign,nonatomic)NSInteger activiyPrice;
@property(assign,nonatomic)NSInteger num;
//@property(nonatomic,copy)NSString*activiyName;
-(instancetype)initWithDict:(NSDictionary *)dict;

@end
