//
//  UIBarButtonItem+Extension.m
//  iBookPa_Ver_0.2
//
//  Created by 鄂鸿桢 on 15/12/4.
//  Copyright © 2015年 ehongzhen. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithImageName: (NSString *)imageName highlightImageName:(NSString *)highlightImageName target:(id)target action:(SEL)action event:(NSString *)event
{
    UIButton *button = [[UIButton alloc] init];
    
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlightImageName] forState:UIControlStateHighlighted];
    [button.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    [button setTitle:event forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    CGFloat btnH = button.currentImage.size.height;
    CGFloat btnW = button.currentImage.size.width + 40;
    button.frame = CGRectMake(0, 0, btnW, btnH);
    
    //监听按钮点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return  [[UIBarButtonItem alloc] initWithCustomView:button];
}
@end
