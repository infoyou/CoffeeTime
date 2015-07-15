//
//  AppDelegate.h
//  CoffeeTime
//
//  Created by fule on 15/6/24.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarController.h"

// Share
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <QZoneConnection/ISSQZoneApp.h>
#import "WeiboSDK.h"
#import "WXApi.h"
#import "AGViewDelegate.h"

@class TabBarController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>

@property (nonatomic, strong) TabBarController *tabBarController;
@property (strong, nonatomic) UIWindow *window;

// Share
@property (nonatomic, readonly) AGViewDelegate *agViewDelegate;


@end

