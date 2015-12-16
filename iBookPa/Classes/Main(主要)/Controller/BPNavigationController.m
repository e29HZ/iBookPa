//
//  BPNavigationController.m
//  iBookPa_Ver_0.2
//
//  Created by 鄂鸿桢 on 15/12/4.
//  Copyright © 2015年 ehongzhen. All rights reserved.
//

#import "BPNavigationController.h"

@interface BPNavigationController ()

@end

@implementation BPNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

/**
 *  拦截所有push进来的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{

    if ( self.viewControllers.count > 0) {// 如果下载push的不是栈底控制器(最先push进来的那个控制器)
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (void)more
{
    [self popToRootViewControllerAnimated:YES];
}
@end
