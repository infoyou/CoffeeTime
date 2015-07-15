
/*!
 @header AppManager.h
 @abstract 系统内存
 @author Adam
 @version 1.00 2014/03/26 Creation
 */

#import <Foundation/Foundation.h>

@interface AppManager : NSObject {
    
}

// User
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userNickName;
@property (nonatomic, copy) NSString *userTicket;
@property (nonatomic, copy) NSString *userPoint;
@property (nonatomic, copy) NSString *userBonusNum;
@property (nonatomic, copy) NSString *userAddressNum;

@property (nonatomic, copy) NSString *userDefaultAddress;

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userPswd;
@property (nonatomic, copy) NSString *userEmail;
@property (nonatomic, copy) NSString *userProvince;
@property (nonatomic, copy) NSString *userImageUrl;

// Product
@property (nonatomic, copy) NSString *productKeyWord;

@property (nonatomic, retain) NSDictionary *profileCellNumberDict;

// 位置信息
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, assign) BOOL isStartFirst;

//是否发表评论
@property (nonatomic) BOOL isUserComment;

+ (AppManager *)instance;

- (void)prepareData;

- (void)rememberUserData:(NSString *)aUserId
                userName:(NSString *)aUserName
                nickName:(NSString *)aNickName
                  avator:(NSString *)avator
                   point:(NSString *)aPoint
                  mobile:(NSString *)aMobile
                    pswd:(NSString *)aPswd;

- (void)updateUserData:(NSString *)aUserId
                  pswd:(NSString *)aPswd;

@end
