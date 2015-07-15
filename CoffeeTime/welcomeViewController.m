//
//  welcomeViewController.m
//  CoffeeTime
//
//  Created by fule on 15/6/25.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import "welcomeViewController.h"
#import "Header.h"

@interface welcomeViewController ()

@end

@implementation welcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)pass:(id)sender {
     UIWindow * window = [UIApplication sharedApplication].keyWindow;
    HomeViewController *mainVC = [[HomeViewController alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:mainVC];
    mainVC.tabBarItem.title = @"订下午茶";
    mainVC.tabBarItem.image = [UIImage imageNamed:@"个人"];
    
    ActivityViewController*activityVC=[[ActivityViewController alloc]init];
    UINavigationController*nav2=[[UINavigationController alloc]initWithRootViewController:activityVC];
    activityVC.tabBarItem.title=@"活动";
    activityVC.tabBarItem.image=[UIImage imageNamed:@"个人"];
    
    JiFenViewController *jiFenVC = [[JiFenViewController alloc] init];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:jiFenVC];
    jiFenVC.tabBarItem.title = @"积分商城";
    jiFenVC.tabBarItem.image = [UIImage imageNamed:@"个人"];
    
    ProfileViewController *mineVC = [[ProfileViewController alloc] init];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:mineVC];
    mineVC.tabBarItem.title = @"我的";
    mineVC.tabBarItem.image = [UIImage imageNamed:@"个人"];
    
    
    UITabBarController *tabBar = [[UITabBarController alloc] init];
    
    CGRect frame = CGRectMake(0, 0, ScreenSize.width, 50*ScreenSize.height/568);
    UIView *view = [[UIView alloc] initWithFrame:frame];
    [view setBackgroundColor:[[UIColor alloc] initWithRed:239/255.0 green:219/255.0 blue:220/255.0 alpha:1]];
    [tabBar.tabBar insertSubview:view atIndex:0];
    
    tabBar.viewControllers = @[nav1,nav2,nav3,nav4];
    tabBar.tabBar.selectedImageTintColor=[UIColor redColor];
    window.rootViewController=tabBar;
}
@end
