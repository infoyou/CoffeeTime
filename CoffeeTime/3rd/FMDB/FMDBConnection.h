//
//  FMDBConnection.h
//  Project
//
//  Created by Adam on 11-11-9.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "FMDatabase.h"
#import "FMResultSet.h"

// Business Object
#import "ShopCartModel.h"

@interface FMDBConnection : NSObject

+ (FMDBConnection *)instance;

@property (nonatomic, retain) FMDatabase *db;

- (void)setup;
- (BOOL)openDB;
- (BOOL)closeDB;

#pragma mark - user
- (void)insertShopCarModelDB:(ShopCartModel *)shopInfo;

- (BOOL)isExistShopCat:(ShopCartModel *)shopInfo;
- (void)updateShopCartDB:(ShopCartModel *)userInfo;
- (void)delShopCartTableBy:(ShopCartModel *)shopCart;

- (void)updateShopCartLogic:(ShopCartModel *)shopCarModel;
- (NSMutableArray *)getStoreAllCartFromDB:(NSString *)storeId;

// 判断是否有数据，需要清空？
- (BOOL)getAllShopCartDataFromDB;
// 判断是否有数据，需要清空！
- (void)delAllShopCartTableData;

- (BOOL)isNeedClearShopCart:(NSString *)storeId;

- (NSMutableArray *)getShopCartShowNumber;

@end
