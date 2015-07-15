//
//  GlobalConstants.h
//  Mall
//
//  Created by Adam on 14-12-1.
//  Copyright (c) 2014年 5adian. All rights reserved.
//

#import "UIDevice+Hardware.h"

#define VERSION         @"1.0.1"

#define UMENG_ANALYS_APP_KEY        @"55a3230967e58eec79006798"

#define PROJECT_DB_NAME             @"ProjectDB"

enum TRANS_SERVER_TY
{
    
    WUADIAN_GETINDEXCONTENT_TY,
    WUADIAN_GETPRODUCTDETAIL_TY,
};

#define	KEYBOARD_ANIMATION_DURATION   0.3f

// URL
#define HOST_URL                    @"http://happyo2o.cn/HappyHour/inter"
#define WEB_URL                     @"http://bpotest.5adian.com/tiyandian_test/5aframework/src/init/webview/proinfo.php"
#define UPLOAD_URL                  @"http://bpotest.5adian.com/tiyandian_test/5AdianV3/uploadimgforandroid.php"

#define GET_METHOD                  @"GET"
#define POST_METHOD                 @"POST"

#define CID_PARAM                   @"IJGASxjqQA" //@"KMKASxjrQQ" // //@"epOASxjrSQ" //
#define USER_PARAM                  @"L8SETw"

#define ORIGINAL_MAX_WIDTH          640.0f
#define kTabBarHeight               49.f

#define OBJ_FROM_DIC(_DIC_, _KEY_) [CommonUtils validateResult:_DIC_ dicKey:_KEY_]
#define STRING_VALUE_FROM_DIC(_DIC_, _KEY_) ((NSString *)OBJ_FROM_DIC(_DIC_, _KEY_) == nil ? @"": (NSString *)OBJ_FROM_DIC(_DIC_, _KEY_))
#define INT_VALUE_FROM_DIC(_DIC_, _KEY_) ((NSString *)OBJ_FROM_DIC(_DIC_, _KEY_)).intValue
#define FLOAT_VALUE_FROM_DIC(_DIC_, _KEY_) ((NSString *)OBJ_FROM_DIC(_DIC_, _KEY_)).floatValue
#define DOUBLE_VALUE_FROM_DIC(_DIC_, _KEY_) ((NSString *)OBJ_FROM_DIC(_DIC_, _KEY_)).doubleValue

#pragma mark - draw UI elements
#define COLOR(r, g, b)            [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define HEX_COLOR(__STR)          [UIColor colorWithHexString:__STR]
#define TRANSPARENT_COLOR         [UIColor clearColor]

#define NAVI_BAR_BG_COLOR            @"0x362e2b"
#define VIEW_BG_COLOR                @"0xeeeeee"

#define barColor  [UIColor colorWithRed:53/255.0 green:46/255.0 blue:43/255.0 alpha:1];

#pragma mark - system info
#define IOS5    5.000000f
#define IOS4    4.000000f
#define IOS6    6.000000f
#define IOS7    7.000000f
#define IOS8    8.000000f
#define IOS4_2  4.2f
#define IPHONE_SIMULATOR			@"iPhone Simulator"

#define CURRENT_OS_VERSION  [[[UIDevice currentDevice] systemVersion] floatValue]

// ######################### Share Begin #########################

typedef NS_ENUM(NSUInteger, VideoShareAlertType) {
    SYSTEM_SETTING_TYPE,
    VideoSinaAlertType = 20,
    VideoQQAlertType,
    VideoWeiXinAlertType,
};

//新浪微博
#define kSinaAppKey    @"833420512" //@"2980000350"
#define kSinaAppSecret @"149e2b750482249ad4195fdeeaa1d035" //@"0092e8fe7462bfeeeab8cb3744317c39"

//QQ&QQ空间
#define kQQAppKey     @"1103963649"
#define kQQAppSecret  @"PRziCk9p4qJR1seI"

//微信
#define kWeiXinKey    @"wxac751dc9c48e9c89"
#define kWeiXinSecret @"845408466861c80e84276323fa3ccce3" //@"1df4db79d42e8e5423ac40b080804d39" //

//ShareSDK平台
#define kShareSDK_Key @"6a46cccf1e16"

// ######################### Share End #########################

// UI
#pragma mark - Alert
#define ShowAlertWithOneButton(Delegate,TITLE,MSG,But) [[[[UIAlertView alloc] initWithTitle:(TITLE) \
message:(MSG) \
delegate:Delegate \
cancelButtonTitle:But \
otherButtonTitles:nil] autorelease] show]

#define ShowAlertWithTwoButton(Delegate,TITLE,MSG,But1,But2) [[[[UIAlertView alloc] initWithTitle:(TITLE) \
message:(MSG) \
delegate:Delegate \
cancelButtonTitle:But1 \
otherButtonTitles:But2, nil] autorelease] show]

@interface GlobalConstants : NSObject {
    
}

@end
