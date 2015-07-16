//
//  ProductModel.h
//  CoffeeTime
//
//  Created by Adam on 15/7/1.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductModel : NSObject


@property (strong, nonatomic) NSString *productId;   //商品id
@property (strong, nonatomic) NSString *productName; //商品名称
@property (strong, nonatomic) NSString *imageUrl;    //商品图片url
@property (strong, nonatomic) NSString *productNo;	 //商品编号
@property (strong, nonatomic) NSString *productKind; //商品类型  例如：蛋糕  咖啡


@property (strong, nonatomic) NSMutableArray *productTypeArray;

- (instancetype)initWithDict:(NSDictionary *)dict typeArray:(NSMutableArray *)typeArray;

@end
