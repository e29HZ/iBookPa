

#import <Foundation/Foundation.h>

#import "Global.h"

@interface BPUser : AVUser
/**
 *  leancloud用户
 */
@property (nonatomic, strong) AVUser *avuser;


/**
 *  用户昵称
 */
@property (nonatomic, copy) NSString *nickname;
/**
 *  用户头像url
 */
@property (nonatomic, copy) NSString *avatarUrl;
/**
 *  用户性别
 */
@property(nonatomic, assign) NSNumber *gender;
/**
 *  生日
 */
@property (nonatomic, weak) NSDate *birth;
/**
 *  年龄
 */
@property (nonatomic, assign) int  age;

/**
 *  学校
 */
@property (nonatomic, copy) NSString *school;
/**
 *  签名
 */
@property (nonatomic, copy) NSString *signnature;
/**
 *  推送Id
 */
@property (nonatomic, copy) NSString *installationId;
/**
 *  最近地理位置
 */
@property (nonatomic, weak) AVGeoPoint *lastLocation;
/**
 *  关注数
 */
@property (nonatomic, assign) int followCount;
/**
 *  粉丝数
 */
@property (nonatomic, assign) int followersCount;
/**
 *  发布的活动数
 */
@property (nonatomic, assign) int pubAtyCount;
/**
 *  报名的活动数
 */
@property (nonatomic, assign) int applyAtyCount;
/**
 *  结束的活动数
 */
@property (nonatomic, assign) int endAtyCount;





InitH(user);



@end
