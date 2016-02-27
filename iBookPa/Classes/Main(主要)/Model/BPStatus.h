//
//  BPStatus.h
//  iBookPa
//
//  Created by X140Yu on 7/8/15.
//  Copyright (c) 2015 X140Yu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Global.h"


/**
 活动种类的枚举
 */
typedef enum BPStatusCategory{
	BPStatusCategoryRead = 15001,		//陪读书
	BPStatusCategoryStudy,			//陪自习
	BPStatusCategoryFindFriend,		//找书友
	BPStatusCategoryExchangeBooks,	//换本书
	BPStatusCategoryAskForBooks,	//求教材
	BPStatusCategoryAskForTeaching,	//求补课
}BPStatusCategory;

@class BPUser;

@interface BPStatus : NSObject

/**
 *  发布者
 */
@property (nonatomic, strong) BPUser *owner;
/**
 *  类型，活动类型，15001 陪看书，15002 去自习，15003 找书友，15004 换本书，15005 求教材，15006 求补课
 */
@property (nonatomic, assign) NSNumber *type;
/**
 *  主题
 */
@property (nonatomic, copy) NSString *title;

/**
 *  对象,15007 仅限男生，15008 仅限女生，15009 男女不限
 */
@property (nonatomic, assign) long target;
/**
 *  结束时间
 */
@property (nonatomic, weak) NSDate *endTime;
/**
 *  地点
 */
@property (nonatomic, copy) NSString *place;
/**
 *  附言
 */
@property (nonatomic, copy) NSString *remark;
/**
 *  是否有效，1为有效，0为过期
 */
@property (nonatomic, assign) int isUseful;
/**
 *  活动评论数
 */
@property (nonatomic, assign) int commentCount;
/**
 *  活动报名数
 */
@property (nonatomic, assign) int applyCount;
/**
 *  活动发布时的地点
 */
@property (nonatomic, weak) AVGeoPoint *pubLocation;




InitH(status);

//+ (NSArray *)status;

/**
 *  根据活动的种类返回种类的字符串
 *
 *  @param category 活动种类
 *
 *  @return 返回的字符串
 */ 
+ (NSString *)statusCategoryNameStringWithStatusCategory:(BPStatusCategory)category;


@end
