//
//  RootViewController.m
//  Mall
//
//  Created by Adam on 14-12-1.
//  Copyright (c) 2014年 5adian. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

@synthesize backView;
@synthesize noNetWorkView;

- (id)init
{
    self = [super init];
    
    if (self) {
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [MobClick beginLogPageView:NSStringFromClass([self class])];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Navi
    self.navigationController.navigationBarHidden = NO;
    
    // Tab Bar
    [self showOrHideTabBar:YES];
    
    [MobClick endLogPageView:NSStringFromClass([self class])];
}

- (void)viewDidLoad
{
    [self initData];

    // Status Bar Style
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
    self.view.backgroundColor = HEX_COLOR(VIEW_BG_COLOR);
    
    [self initNoNetWorkView];
    
    
    [self loadLocation];
    
    // navi bar
    if (CURRENT_OS_VERSION >= IOS7) {
        [self.navigationController.navigationBar setBarTintColor:HEX_COLOR(NAVI_BAR_BG_COLOR)];
    }
    
    [self.navigationController.navigationBar setBackgroundImage:[CommonUtils createImageWithColor:HEX_COLOR(NAVI_BAR_BG_COLOR)] forBarMetrics:UIBarMetricsDefault];
    
//    self.navigationController.visibleViewController.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    //导航栏的标题颜色UITextAttributeTextColor
    NSDictionary *dict = @{NSFontAttributeName :  [UIFont systemFontOfSize:18],
                           NSForegroundColorAttributeName : [UIColor whiteColor]};
    [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    //设置navigationbar的半透明
    [self.navigationController.navigationBar setTranslucent:NO];
    //设置navigationbar上左右按钮字体颜色
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
//    // Navi
//    self.navigationController.navigationBarHidden = NO;
//
//    // Tab Bar
//    [self showOrHideTabBar:YES];
    
    [self adjustView];
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - init data
- (void)initData
{
    
}

#pragma mark - adjust view
- (void)adjustView
{
    
}

#pragma mark - handle status bar issue for ios7
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

#pragma mark
#pragma mark - is Connection Available
- (BOOL) isConnectionAvailable
{
    
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            //NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            //NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            //NSLog(@"3G");
            break;
    }
    
    if (!isExistenceNetwork) {
        
        [[[UIAlertView alloc] initWithTitle:@"当前网络不可用,\n请检查网络连接!"
                                    message:@""
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
        return NO;
    }
    
    return isExistenceNetwork;
}

#pragma mark - image for gesture
- (void)addTapGestureRecognizer:(UIView *)targetView
{
    targetView.userInteractionEnabled = YES;
    UITapGestureRecognizer *swipeGR = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                               action:@selector(imageviewTouchEvents:)];
    swipeGR.delegate = self;
    
    [targetView addGestureRecognizer:swipeGR];
}

- (void)imageviewTouchEvents:(UIGestureRecognizer *)gestureRecognizer
{
    UIView *view = (UIView*)[gestureRecognizer view];
    int viewTag = view.tag;
    
    DLog(@"%d is touched",viewTag);
}

#pragma mark - show or hide tab bar
- (void)showOrHideTabBar:(BOOL)flag
{
    //tabbar消失
    [((AppDelegate *)APP_DELEGATE).tabBarController hidesTabBar:flag animated:NO];
}

#pragma mark - show Alert
- (void)showAlert:(NSString*)infoStr
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:infoStr delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

#pragma mark - 定时 Alert
- (void)showTimeAlert:(NSString*)title message:(NSString*)message
{
    
    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:title
                                                          message:message
                                                         delegate:nil
                                                cancelButtonTitle:nil
                                                otherButtonTitles:nil];
    
    [NSTimer scheduledTimerWithTimeInterval:1.5f
                                     target:self
                                   selector:@selector(timerFireMethod:)
                                   userInfo:promptAlert
                                    repeats:NO];
    [promptAlert show];
}

- (void)timerFireMethod:(NSTimer*)theTimer
{
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert =NULL;
}

- (void)setNaviItemEdit
{
    //编辑按钮
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem.title = @"编辑";
}


//点击编辑按钮
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    [super setEditing:editing animated:animated];
    
    // Don't show the Back button while editing.
    
    [self.navigationItem setHidesBackButton:editing animated:YES];
    
    if (editing) {
        self.navigationItem.rightBarButtonItem.title = @"完成";
        NSLog(@"abc");
        
    } else {//点击完成按钮
        self.navigationItem.rightBarButtonItem.title = @"编辑";
        NSLog(@"123");
    }
}

#pragma mark - 无网络时处理
- (void)initNoNetWorkView
{
    UIView *tmpNetWorkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    tmpNetWorkView.backgroundColor = HEX_COLOR(VIEW_BG_COLOR);
    
    UIImageView *noNetWorkImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nonContent.png"]];
    noNetWorkImgV.frame = CGRectMake((SCREEN_WIDTH - 132)/2, 80, 132, 132);
    [tmpNetWorkView addSubview:noNetWorkImgV];
    
    UILabel *promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 270, SCREEN_WIDTH, 30)];
    promptLabel.textAlignment = NSTextAlignmentCenter;
    promptLabel.text = @"啊哦! 暂时没有记录哦!";
    promptLabel.textColor = HEX_COLOR(@"0x333333");
    [tmpNetWorkView addSubview:promptLabel];
    
    UIButton *btnNoNetWork = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnNoNetWork setFrame:CGRectMake((SCREEN_WIDTH - 108)/2, 320, 108 , 36)];
    [btnNoNetWork setImage:[UIImage imageNamed:@"noNetWork.png"] forState:UIControlStateNormal];
    [btnNoNetWork addTarget:self action:@selector(btnNoNetWorkClicked:) forControlEvents:UIControlEventTouchUpInside];
    [tmpNetWorkView addSubview:btnNoNetWork];
    
    self.noNetWorkView = tmpNetWorkView;
}

#pragma mark －无网络时点击事件
- (void)btnNoNetWorkClicked:(id)sender
{
    
}

#pragma mark - 背景灰色
- (void)showShadowView
{
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,  SCREEN_HEIGHT)];
    self.backView.backgroundColor = [UIColor grayColor];
    self.backView.alpha = 0.5;
    
    [APP_DELEGATE.window addSubview:self.backView];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
}

// 监听键盘
- (void)initLisentingKeyboard
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
#ifdef __IPHONE_5_0
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 5.0) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
#endif
}

#pragma mark - animate
- (void)upAnimate
{
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= _animatedDistance;
    
    [UIView animateWithDuration:KEYBOARD_ANIMATION_DURATION
                          delay:0.0f
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.view.frame = viewFrame;
                     }
                     completion:^(BOOL finished){
                         
                     }];
}

- (void)downAnimate
{
    if (_animatedDistance == 0) {
        return;
    }
    
    //    CGRect viewFrame = self.view.frame;
    //    viewFrame.origin.y += _animatedDistance;
    
    CGRect viewFrame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    
    [UIView animateWithDuration:KEYBOARD_ANIMATION_DURATION
                          delay:0.0f
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.view.frame = viewFrame;
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
    _animatedDistance = 0;
}

#pragma mark - keyboard show or hidden
-(void)autoMovekeyBoard:(float)h withDuration:(float)duration
{
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        CGRect rect = self.view.frame;
        if (h) {
            if (SCREEN_HEIGHT > 480) {
                self.view.frame = CGRectMake(0.0f, -40, self.view.frame.size.width, self.view.frame.size.height);
            } else {
                self.view.frame = CGRectMake(0.0f, -110, self.view.frame.size.width, self.view.frame.size.height);
            }
            
        } else {
            rect.origin.y = ([CommonUtils is7System] ? 0 : 0);
            self.view.frame = rect;
        }
        
    } completion:^(BOOL finished) {
        // stub
    }];
    
}

#pragma mark - Responding to keyboard events
- (void)keyboardWillShow:(NSNotification *)notification {
    
    /*
     Reduce the size of the text view so that it's not obscured by the keyboard.
     Animate the resize so that it's in sync with the appearance of the keyboard.
     */
    
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    // Get the top of the keyboard as the y coordinate of its origin in self's view's coordinate system. The bottom of the text view's frame should align with the top of the keyboard's final position.
    CGRect keyboardRect = [aValue CGRectValue];
    
    // Get the duration of the animation.
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    // Animate the resize of the text view's frame in sync with the keyboard's appearance.
    [self autoMovekeyBoard:keyboardRect.size.height withDuration:animationDuration];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    NSDictionary* userInfo = [notification userInfo];
    
    /*
     Restore the size of the text view (fill self's view).
     Animate the resize so that it's in sync with the disappearance of the keyboard.
     */
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [self autoMovekeyBoard:0 withDuration:animationDuration];

}

#pragma mark - activity indicator view
- (void)addActivityIndicatorView
{
    
    // bg
    self.activityIndicatorViewBG = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 67) / 2, 182, 67, 67)];
    self.activityIndicatorViewBG.backgroundColor = [UIColor grayColor];
    self.activityIndicatorViewBG.alpha = 0.7f;
    
    // activity indicator view
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicatorView.frame = CGRectMake(15, 15, 37, 37);
    [self.activityIndicatorViewBG addSubview:self.activityIndicatorView];
    
    self.activityIndicatorViewBG.layer.cornerRadius = 6;
    self.activityIndicatorViewBG.layer.masksToBounds = YES;
    
    [self.view addSubview:self.activityIndicatorViewBG];
}

- (void)showActivityIndicatorView
{
    
    self.activityIndicatorViewBG.hidden = NO;
    self.activityIndicatorView.hidden = NO;
    [self.activityIndicatorView startAnimating];
}

- (void)closeActivityIndicatorView
{
    [self.activityIndicatorView stopAnimating];
    self.activityIndicatorView.hidden = YES;
    self.activityIndicatorViewBG.hidden = YES;
}

#pragma mark - Share Methods

- (void)initAllSharePlat
{
    
    NSString *title = [NSString stringWithFormat:@"估一估谁是任性土豪---"];
    NSString *shareUrl = [NSString stringWithFormat:@"http://www.hurongclub.com/download/download.html"];
    
    if (!self.activityView) {
        self.activityView = [[HYActivityView alloc]initWithTitle:@"分享至" referView:self.view];
        
        //横屏会变成一行6个, 竖屏无法一行同时显示6个, 会自动使用默认一行4个的设置.
        self.activityView.numberOfButtonPerLine = 4;
        
        NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"Resource" ofType:@"bundle"];
        NSBundle *resourceBundle = nil;
        if ([resourcePath length] > 0) {
            resourceBundle = [[NSBundle alloc]initWithPath:resourcePath];
        }
        
        
        NSString *sinaIconPath = [resourceBundle  pathForResource:@"Icon_7/sns_icon_1" ofType:@"png"];
        UIImage *sinaIcon = [UIImage imageWithContentsOfFile:sinaIconPath];
        ButtonView *bv = [[ButtonView alloc]initWithText:@"新浪微博" image:sinaIcon handler:^(ButtonView *buttonView){
            [AppManager instance].isUserComment = YES;
            [self sendVideoMessageInSinaWithTitle:title withImage:@"" withVideoUrl:shareUrl withContent:@""];
        }];
        [self.activityView addButtonView:bv];
        
        NSString *QQIconPath = [resourceBundle  pathForResource:@"Icon_7/sns_icon_6" ofType:@"png"];
        UIImage *QQIcon = [UIImage imageWithContentsOfFile:QQIconPath];
        bv = [[ButtonView alloc]initWithText:@"QQ空间" image:QQIcon handler:^(ButtonView *buttonView){
            if (![self checkHasInstallQQ]) {
                return ;
            }
            
            [self sendShareVideoWithType:ShareTypeQQSpace withTitle:title withContent:@"" withImage:@"" withVideoUrl:shareUrl];
        }];
        [self.activityView addButtonView:bv];
        
        NSString *wxIconPath = [resourceBundle  pathForResource:@"Icon_7/sns_icon_22" ofType:@"png"];
        UIImage *wxIcon = [UIImage imageWithContentsOfFile:wxIconPath];
        bv = [[ButtonView alloc]initWithText:@"微信" image:wxIcon handler:^(ButtonView *buttonView){
            if (![self checkHasInstallWeiXin]) {
                return ;
            }
            
            [self sendShareVideoWithType:ShareTypeWeixiSession withTitle:title withContent:@"" withImage:@"" withVideoUrl:shareUrl];
        }];
        [self.activityView addButtonView:bv];
        
        NSString *wxFriIconPath = [resourceBundle  pathForResource:@"Icon_7/sns_icon_23" ofType:@"png"];
        UIImage *wxFriIcon = [UIImage imageWithContentsOfFile:wxFriIconPath];
        bv = [[ButtonView alloc]initWithText:@"微信朋友圈" image:wxFriIcon handler:^(ButtonView *buttonView){
            if (![self checkHasInstallWeiXin]) {
                return ;
            }
            
            [self sendShareVideoWithType:ShareTypeWeixiTimeline withTitle:title withContent:@"" withImage:@"" withVideoUrl:shareUrl];
        }];
        [self.activityView addButtonView:bv];
        
    }
    
    [self.activityView show];
}

/*!
 @method
 @abstract	分享视频信息
 @param     type         分享平台类型
 @param     title        分享视频名称
 @param     videoContent 分享视频简介
 @param     imageUrl     分享视频的图片
 @param     playUrl      分享视频的播放地址
 @discussion
 @return
 */
- (void)sendShareVideoWithType:(ShareType)type
                     withTitle:(NSString *)title
                   withContent:(NSString *)videoContent
                     withImage:(NSString *)imageUrl
                  withVideoUrl:(NSString *)playUrl
{
    // Share Image
    UIImage *shareImg = [CommonUtils loadImageFromDocument:@"/share" file:@"share.png"];
    
    id<ISSContent> content = [ShareSDK content:videoContent
                                defaultContent:@"分享了一个活动"
                                         image:[ShareSDK pngImageWithImage:shareImg]
                                         title:title
                                           url:playUrl
                                   description:nil
                                     mediaType:SSPublishContentMediaTypeNews];
    
    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:((AppDelegate *)APP_DELEGATE).agViewDelegate];
    
    
    
    [ShareSDK shareContent:content
                      type:type
               authOptions:authOptions
             statusBarTips:NO
                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                        
                        if (state == SSPublishContentStateSuccess)
                        {
                            [self showAlert:@"分享成功"];
                        }
                        else if (state == SSPublishContentStateFail)
                        {
                            [self showAlert:@"分享失败"];
                        }
                    }];
    
}

/*!
 @method
 @abstract	分享视频信息到新浪微博
 @param     title        分享视频名称
 @param     videoContent 分享视频简介
 @param     imageUrl     分享视频的图片
 @param     playUrl      分享视频的播放地址
 @discussion
 @return
 */
/***新浪微博分享只能分享content和image，若要分享视频，需要把视频链接写在Content里面***/
- (void)sendVideoMessageInSinaWithTitle:(NSString *)title
                              withImage:(NSString *)imageUrl
                           withVideoUrl:(NSString *)playUrl
                            withContent:(NSString *)videoContent
{
    
    NSString *sinaContent = [NSString stringWithFormat:@"%@ \r\n%@",title,playUrl];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:sinaContent
                                       defaultContent:@"分享了一个活动"
                                                image:[ShareSDK jpegImageWithImage:[UIImage imageNamed:@"Parsonal_activityShare.jpg"] quality:1.0]
                                                title:title
                                                  url:nil
                                          description:videoContent
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK clientShareContent:publishContent
                            type:ShareTypeSinaWeibo
                   statusBarTips:NO
                          result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                              
                              if (state == SSPublishContentStateSuccess)
                              {
                                  [AppManager instance].isUserComment = NO;
                                  [[UIApplication sharedApplication] setStatusBarHidden:NO];
                                  [self showAlert:@"分享成功!"];
                              }
                              else if (state == SSPublishContentStateFail)
                              {
                                  [AppManager instance].isUserComment = NO;
                                  [[UIApplication sharedApplication] setStatusBarHidden:NO];
                                  [self showAlert:@"分享失败!"];
                              }
                              
                              
                          }];
}


//检查是否安装QQ
- (BOOL)checkHasInstallQQ
{
    if ([QQApi isQQInstalled] && [QQApi isQQSupportApi]) {
        return YES;
    }
    else
    {
        [self showAlert:@"您还没有安装QQ,\n请先安装后进行分享"];
        //[self showAlertWithTitle:@"未安装QQ客户端,\n是否去App Store下载?" withTag:VideoQQAlertType];
        return NO;
    }
}


//检查是否安装微信
- (BOOL)checkHasInstallWeiXin
{
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        return YES;
    }
    else
    {
        [self showAlert:@"您还没有安装微信,\n请先安装后进行分享"];
        // [self showAlertWithTitle:@"未安装微信客户端,\n是否去App Store下载?" withTag:VideoWeiXinAlertType];
        return NO;
    }
}

- (void)showAlertWithTitle:(NSString *)title withTag:(NSUInteger)tag
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:nil delegate:self cancelButtonTitle:@"以后再说" otherButtonTitles:@"现在下载", nil];
    [alertView setTag:tag];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag) {
            
        case SYSTEM_SETTING_TYPE:
        {
            // Send the user to the Settings for this app
            if (buttonIndex == 1) {
                NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                [[UIApplication sharedApplication] openURL:settingsURL];
            }
        }
            break;
            
        case VideoQQAlertType:
        {
            if (buttonIndex == 1) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://appsto.re/cn/kOsHA.i"]];
            }
        }
            break;
            
        case VideoSinaAlertType:
        {
            if (buttonIndex == 1) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://appsto.re/cn/fh06u.i"]];
            }
        }
            break;
            
        case VideoWeiXinAlertType:
        {
            if (buttonIndex == 1) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://appsto.re/cn/S8gTy.i"]];
            }
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - location
- (void)loadLocation
{
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    [self.locationManager startUpdatingLocation];
}

#pragma mark CLLocationManagerDelegate method
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    self.currentLocation = [locations lastObject];
    
    [AppManager instance].latitude = [NSString stringWithFormat:@"%g", self.currentLocation.coordinate.latitude];
    [AppManager instance].longitude = [NSString stringWithFormat:@"%g", self.currentLocation.coordinate.longitude];
    
    /*
     NSLog(@"latitude %@",
     [NSString stringWithFormat:@"%g", self.currentLocation.coordinate.latitude]);
     NSLog(@"longitude %@",
     [NSString stringWithFormat:@"%g\u00B0", self.currentLocation.coordinate.longitude]);
     NSLog(@"horizontalAccuracy %@",
     [NSString stringWithFormat:@"%gm", self.currentLocation.horizontalAccuracy]);
     NSLog(@"verticalAccuracy %@",
     [NSString stringWithFormat:@"%gm", self.currentLocation.verticalAccuracy]);
     NSLog(@"altitude %@",
     [NSString stringWithFormat:@"%gm", self.currentLocation.altitude]);
     */
    
    if ([AppManager instance].isStartFirst) {
        
//        [self uploadLocationData];
        
        [AppManager instance].isStartFirst = NO;
    }
}

#pragma mark upload Location msg
- (void)uploadLocationData
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *dateId = [NSString stringWithFormat:@"%.0f", a];
    
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] init];
    [dataDict setObject:[AppManager instance].longitude forKey:@"lon"];
    [dataDict setObject:[AppManager instance].latitude forKey:@"lat"];
    [dataDict setObject:dateId forKey:@"time"];
    
    NSMutableDictionary *paramDict = [CommonUtils getParamDict:@"uploadLonLat"
                                                      dataDict:dataDict];
    
    [self showHUDWithText:@"正在加载"
                   inView:self.view
              methodBlock:^(CompletionBlock completionBlock, ATMHud *hud)
     {
         
         [HttpRequestData dataWithDic:paramDict
                          requestType:POST_METHOD
                            serverUrl:HOST_URL
                             andBlock:^(NSString*requestStr) {
                                 
                                 if (completionBlock) {
                                     completionBlock();
                                 }
                                 
                                 if ([requestStr isEqualToString:@"Start"]) {
                                     
                                     DLog(@"Start");
                                 } else if([requestStr isEqualToString:@"Failed"]) {
                                     
                                     DLog(@"Failed");
                                     
                                 } else {
                                     
                                     NSDictionary* backDic = [HttpRequestData jsonValue:requestStr];
                                     NSLog(@"requestStr = %@", backDic);
                                     
                                     if (backDic != nil) {
                                         
                                         NSString *errCodeStr = (NSString *)[backDic valueForKey:@"errcode"];
                                         
                                         if ( [errCodeStr integerValue] == 0 ) {
                                             
                                         } else {
                                             
                                             //  [self showHUDWithText:[backDic valueForKey:@"errmsg"]];
                                         }
                                     }
                                 }
                             }];
     }];
}

@end
