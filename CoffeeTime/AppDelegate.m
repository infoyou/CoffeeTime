//
//  AppDelegate.m
//  CoffeeTime
//
//  Created by Adam on 15/6/24.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "ProfileViewController.h"
#import "ActivityViewController.h"
#import "Header.h"
#import "BaseNavigationController.h"
#import "WXApi.h"
#import "OrderDetailViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize tabBarController;
@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self enterHomeVC];
    
    [WXApi registerApp:WXAppId];
    
    [[AppManager instance] prepareData];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)enterHomeVC {
    
    // Home
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    BaseNavigationController *homeNav = [[BaseNavigationController alloc] initWithRootViewController:homeVC];
    
    // Activity
    ActivityViewController *activityVC=[[ActivityViewController alloc] init];
    BaseNavigationController *activityNav = [[BaseNavigationController alloc] initWithRootViewController:activityVC];
    
    // 晒单
    HeDanViewController *orderVC = [[HeDanViewController alloc] init];
    BaseNavigationController *jiFenNav = [[BaseNavigationController alloc] initWithRootViewController:orderVC];
    
    // Profile
    ProfileViewController *profileVC = [[ProfileViewController alloc] init];
    BaseNavigationController *profileNav = [[BaseNavigationController alloc] initWithRootViewController:profileVC];
    
    NSArray *tabVCArray = [NSArray arrayWithObjects:homeNav, activityNav, jiFenNav, profileNav, nil];
    
    NSMutableDictionary *imgDic1 = [NSMutableDictionary dictionaryWithCapacity:3];
    [imgDic1 setObject:[UIImage imageNamed:@"Tabbar1.png"] forKey:@"Default"];
    [imgDic1 setObject:[UIImage imageNamed:@"Tabbar1.png"] forKey:@"Highlighted"];
    [imgDic1 setObject:[UIImage imageNamed:@"Tabbar1_sel.png"] forKey:@"Seleted"];
    
    NSMutableDictionary *imgDic2 = [NSMutableDictionary dictionaryWithCapacity:3];
    [imgDic2 setObject:[UIImage imageNamed:@"Tabbar2.png"] forKey:@"Default"];
    [imgDic2 setObject:[UIImage imageNamed:@"Tabbar2.png"] forKey:@"Highlighted"];
    [imgDic2 setObject:[UIImage imageNamed:@"Tabbar2_sel.png"] forKey:@"Seleted"];
    
    NSMutableDictionary *imgDic3 = [NSMutableDictionary dictionaryWithCapacity:3];
    [imgDic3 setObject:[UIImage imageNamed:@"Tabbar3.png"] forKey:@"Default"];
    [imgDic3 setObject:[UIImage imageNamed:@"Tabbar3.png"] forKey:@"Highlighted"];
    [imgDic3 setObject:[UIImage imageNamed:@"Tabbar3_sel.png"] forKey:@"Seleted"];
    
    NSMutableDictionary *imgDic4 = [NSMutableDictionary dictionaryWithCapacity:3];
    [imgDic4 setObject:[UIImage imageNamed:@"Tabbar4.png"] forKey:@"Default"];
    [imgDic4 setObject:[UIImage imageNamed:@"Tabbar4.png"] forKey:@"Highlighted"];
    [imgDic4 setObject:[UIImage imageNamed:@"Tabbar4_sel.png"] forKey:@"Seleted"];
    
    NSArray *imgArr = [NSArray arrayWithObjects:imgDic1, imgDic2, imgDic3, imgDic4, nil];
    
    self.tabBarController = [[TabBarController alloc] initWithViewControllers:tabVCArray imageArray:imgArr];
    
    [self.window addSubview:self.tabBarController.view];
    self.window.rootViewController = self.tabBarController;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL) application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WXApi handleOpenURL:url delegate:self];
}

- (void)onResp:(BaseResp *)resp
{
    if ([resp isKindOfClass:[PayResp class]])
    {
        PayResp *response = (PayResp *)resp;
        
        switch (response.errCode) {
                
            case WXSuccess: {
                
                NSNotification *notification = [NSNotification notificationWithName:ORDER_PAY_NOTIFICATION object:@"success"];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                NSString *strTitle = [NSString stringWithFormat:@"支付结果"];
                NSString *strMsg = [NSString stringWithFormat:@"%@", @"支付成功"];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle
                                                                message:strMsg
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
                [alert show];
                
                break;
            }
                
            default: {
//                NSNotification *notification = [NSNotification notificationWithName:ORDER_PAY_NOTIFICATION object:@"fail"];
//                [[NSNotificationCenter defaultCenter] postNotification:notification];
                NSString *strTitle = [NSString stringWithFormat:@"支付结果"];
                NSString *strMsg = [NSString stringWithFormat:@"%@", @"支付失败"];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle
                                                                message:strMsg
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
                [alert show];
                
                break;
            }
        }
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [AppManager instance].isStartFirst = YES;
    NSLog(@"applicationDidBecomeActive");
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    NSLog(@"applicationWillResignActive");
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
