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



@property (nonatomic, strong) BPStatus *status;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
