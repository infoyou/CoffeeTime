//
//  GoodsModel.h
//  CoffeeTime
//
//  Created by fule on 15/7/1.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsModel : NSObject

@property(strong,nonatomic)NSString *imageName;//商品图片

@property(strong,nonatomic)NSString *goodsTitle;//商品标题


@property(strong,nonatomic)NSMutableArray*goodsArray;

-(instancetype)initWithDict:(NSDictionary *)dict;
@end
