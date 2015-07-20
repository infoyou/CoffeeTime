//
//  Header.h
//  CoffeeTime
//
//  Created by Adam on 15/6/25.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#ifndef CoffeeTime_Header_h
#define CoffeeTime_Header_h

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "JiFenViewController.h"
#import "ProfileViewController.h"
#import "ActivityViewController.h"
#import "ProductListViewController.h"
#import "ShopCartViewController.h"
#import "OrderDetailViewController.h"
#import "OrderListViewController.h"

//获取设备的屏幕的大小
#define ScreenSize [UIScreen mainScreen].bounds.size
//微信支付参数：
//注意 ：参数需要你自己提供
//*/
#define WXAppId @"wx22fb31513eee1e9a"
#define WXAppSecret @"e662742c5f7c4a348a15dcf5577a7308"

/**
 * 微信开放平台和商户约定的支付密钥
 *
 * 注意：不能hardcode在客户端，建议genSign这个过程由服务器端完成
 */
#define  WXPartnerKey @"77af8fbccac763a2b1fc1b48c162c716"

/**
 * 微信开放平台和商户约定的支付密钥
 *
 * 注意：不能hardcode在客户端，建议genSign这个过程由服务器端完成
 */
#define  WXAppKey @"lLfV7BJCs3hsYFJ8t64eaV5wntdkPN7aKrUna8u0SKTY8TZMTxWybovtYw8YWXMIBCZiUAOp0EpUwI0XD7OF3kuCTG4F5y6xf6l1kbtVhdbFOXNmkOSE3xNnVDdEyBLd"

/**
 *  微信公众平台商户模块生成的ID
 */
#define WXPartnerId  @"1234492801"

#define ORDER_PAY_NOTIFICATION @"ORDER_PAY_NOTIFICATION"
#endif
