//
//  ShopCartModel.h
//  CoffeeTime
//
//  Created by Adam on 15/7/15.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopCartModel : NSObject

//shoppingCartlist			购物车集合
//shoppingCartId	shoppingCartlist	String	购物车ID
//userId	shoppingCartlist	String	用户ID
//commodityId	shoppingCartlist	String	商品ID
//commodityTypeId	shoppingCartlist	String	商品属性
//commodityNumber	shoppingCartlist	String	商品编码
//commodityPrice	shoppingCartlist	String	商品价格单价
//commodityAmount	shoppingCartlist	String	商品数量
//shopId	shoppingCartlist	String	店铺ID
//shopName	shoppingCartlist	String	店铺名称
//createTime	shoppingCartlist	String	加入购物车时间YYYY-MM-DD HH-mm-ss

@property (strong, nonatomic) NSString *shopName;//商店名称
@property (strong, nonatomic) NSString *shopId;//商店ID
@property (strong, nonatomic) NSString *productId;//商品ID
@property (strong, nonatomic) NSString *productName;//商品ID
@property (strong, nonatomic) NSString *unitName;
@property (strong, nonatomic) NSString *unitId;//商品属性ID
@property (strong, nonatomic) NSString *productNo;//商品编码
@property (strong, nonatomic) NSNumber *unitPrice;//商品单价
@property (strong, nonatomic) NSNumber *shopCartNum;//商品个数


- (instancetype)initWithDict:(NSDictionary *)dict;

@end
