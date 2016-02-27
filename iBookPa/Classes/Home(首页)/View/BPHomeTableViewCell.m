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
    
    
}



- (void)awakeFromNib {
    // Initialization code
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    
    
}


@end
