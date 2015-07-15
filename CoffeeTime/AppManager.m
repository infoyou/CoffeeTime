
#import "AppManager.h"
#import "GlobalConstants.h"
#import "CommonUtils.h"

@implementation AppManager {
}

// User
@synthesize userName;
@synthesize userNickName;
@synthesize userTicket;
@synthesize userPoint;
@synthesize userBonusNum;
@synthesize userAddressNum;

@synthesize userId;
@synthesize userPswd;
@synthesize userEmail;
@synthesize userImageUrl;

@synthesize userDefaultAddress;
@synthesize userProvince;

// Product
@synthesize productKeyWord;

@synthesize profileCellNumberDict;

static AppManager *shareInstance = nil;

+ (AppManager *)instance {
    @synchronized(self) {
        if (nil == shareInstance) {
            shareInstance = [[self alloc] init];
        }
    }
    
    return shareInstance;
}

- (void)prepareData
{
    
    [self initUser];
}

- (void)initUser
{
    
    [AppManager instance].longitude = @"121";
    [AppManager instance].latitude = @"31";
    
    NSString *userIdStr = [self userIdRemembered];
    if (userIdStr != nil && userIdStr.length > 0) {
        
        [AppManager instance].userId = userIdStr;
        [AppManager instance].userName = [self userNameRemembered];
        [AppManager instance].userNickName = [self nickNameRemembered];
        [AppManager instance].userImageUrl = [self avatorRemembered];
        [AppManager instance].userPoint = [self pointRemembered];
        [AppManager instance].userPswd = [self pswdRemembered];
    } else {
        
        [AppManager instance].userId = @""; //@"L8SETw";
        [AppManager instance].userName = @"我";
        [AppManager instance].userNickName = @"Adam";
        [AppManager instance].userTicket = @"";
        [AppManager instance].userImageUrl = @"";
        [AppManager instance].userPoint = @"";
        [AppManager instance].userPswd = @"";
    }
}

- (NSString *) userIdRemembered {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
}

- (NSString *) userNameRemembered
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
}

- (NSString *) nickNameRemembered
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"nickName"];
}

- (NSString *) avatorRemembered
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"avator"];
}

- (NSString *) pointRemembered
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"point"];
}

- (NSString *) mobileRemembered
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"mobile"];
}

- (NSString *) pswdRemembered
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"pswd"];
}

- (void)rememberUserData:(NSString *)aUserId
                userName:(NSString *)aUserName
                nickName:(NSString *)aNickName
                  avator:(NSString *)avator
                   point:(NSString *)aPoint
                  mobile:(NSString *)aMobile
                    pswd:(NSString *)aPswd
{
    NSUserDefaults *_def = [NSUserDefaults standardUserDefaults];
    
    if(userId == nil) {
        
        [_def removeObjectForKey:@"userId"];
        [_def removeObjectForKey:@"userName"];
        [_def removeObjectForKey:@"nickName"];
        [_def removeObjectForKey:@"avator"];
        [_def removeObjectForKey:@"point"];
        [_def removeObjectForKey:@"mobile"];
        [_def removeObjectForKey:@"pswd"];
    } else {
        
        [_def setObject:aUserId forKey:@"userId"];
        [_def setObject:aUserName forKey:@"userName"];
        [_def setObject:aNickName forKey:@"nickName"];
        [_def setObject:avator forKey:@"avator"];
        [_def setObject:aPoint forKey:@"point"];
        [_def setObject:aMobile forKey:@"mobile"];
        [_def setObject:aPswd forKey:@"pswd"];
    }
    
    [_def synchronize];
}

- (void)updateUserData:(NSString *)aUserId
                    pswd:(NSString *)aPswd
{
    NSUserDefaults *_def = [NSUserDefaults standardUserDefaults];
    
    if(userId == nil) {
        
        [_def removeObjectForKey:@"userId"];
        [_def removeObjectForKey:@"pswd"];
    } else {
        
        [_def setObject:aUserId forKey:@"userId"];
        [_def setObject:aPswd forKey:@"pswd"];
    }
    
    [_def synchronize];
}

@end
