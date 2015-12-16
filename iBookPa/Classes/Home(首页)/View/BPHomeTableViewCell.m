//
//  BPHomeTableViewCell.m
//  iBookPa_Ver_0.2
//
//  Created by 鄂鸿桢 on 15/12/9.
//  Copyright © 2015年 ehongzhen. All rights reserved.
//

#import "BPHomeTableViewCell.h"
#import "BPStatus.h"
#import "BPUser.h"

@interface BPHomeTableViewCell ()
/**
 *  头像按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *iconBtn;
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


@end

@implementation BPHomeTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"homeCell";
    //1.去缓存中取
    BPHomeTableViewCell *homeCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    //2.创建cell
    if (homeCell == nil) {
        //如果找不到，从xib中创建cell
        homeCell = [[[NSBundle mainBundle] loadNibNamed:@"BPHomeTableViewCell" owner:nil options:nil]lastObject];
    }
    return homeCell;
}

- (void)setBPStatus:(BPStatus *)status
{
    _status = status;
    //设置用户头像
    [self.iconBtn setImage:[UIImage imageNamed:status.owner.avatarUrl] forState:UIControlStateNormal];
    //设置用户昵称
    self.nicknameLabel.text = status.owner.nickname;
    //设置用户性别
    if (status.owner.gender == 1) {
        [self.sexBtn setTitle:[NSString stringWithFormat:@"男 %d",status.owner.age] forState:UIControlStateNormal];
        [self.sexBtn setBackgroundColor:[UIColor blueColor]];
    }
    else
    {
        [self.sexBtn setTitle:[NSString stringWithFormat:@"女 %d",status.owner.age] forState:UIControlStateNormal];
        [self.sexBtn setBackgroundColor:[UIColor redColor]];
    }
    //设置截止时间
    
    //设置主题
    self.topicLabel.text = status.title;
    //设置地点
    self.placeLabel.text = status.place;
    //设置条件
    if (status.target == 0) {
        self.targetLabel.text = @"男女不限";
    }
    else if (status.target == 1)
    {
        self.targetLabel.text = @"仅限男生";
    }
    else
    {
        self.targetLabel.text = @"仅限女生";
    }
    //设置备注
    self.remarkLabel.text = status.remark;
    //评论功能
    
    //报名功能
    
    
}



- (void)awakeFromNib {
    // Initialization code
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    
    
}


@end
