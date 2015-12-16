//
//  UIBarButtonItem+Extension.h
//  iBookPa_Ver_0.2
//
//  Created by 鄂鸿桢 on 15/12/4.
//  Copyright © 2015年 ehongzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithImageName: (NSString *)imageName highlightImageName:(NSString *)highlightImageName target:(id)target action:(SEL)action event:(NSString *)event;

@end
