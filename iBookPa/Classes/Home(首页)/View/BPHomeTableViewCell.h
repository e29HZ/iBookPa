//
//  BPHomeTableViewCell.h
//  iBookPa_Ver_0.2
//
//  Created by 鄂鸿桢 on 15/12/9.
//  Copyright © 2015年 ehongzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BPStatus;

@interface BPHomeTableViewCell : UITableViewCell
/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

/**
 *  昵称
 */
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
/**
 *  性别年龄
 */
@property (weak, nonatomic) IBOutlet UIButton *sexBtn;

/*
 *  截止时间
 */
@property (weak, nonatomic) IBOutlet UILabel *endtimeLabel;
/**
 *  主题按钮
 */
@property (weak, nonatomic) IBOutlet UILabel *topicLabel;
/**
 *  地点
 */
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
/**
 *  条件
 */
@property (weak, nonatomic) IBOutlet UILabel *targetLabel;

/**
 *  备注
 */
@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;
/**
 *  类型
 */
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
/**
 *  评论按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
/**
 *  报名按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *joinBtn;


@property (nonatomic, strong) BPStatus *status;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
