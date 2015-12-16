//
//  BPTabBarViewController.m
//  iBookPa_Ver_0.2
//
//  Created by 鄂鸿桢 on 15/12/4.
//  Copyright © 2015年 ehongzhen. All rights reserved.
//

#import "BPTabBarViewController.h"
#import "BPHomeTableViewController.h"
#import "BPNearTableViewController.h"
#import "BPMessageTableViewController.h"
#import "BPProfileTableViewController.h"
#import "BPNavigationController.h"

@interface BPTabBarViewController ()

@end

@implementation BPTabBarViewController

- (void)viewDidLoad {
    
    
    BPHomeTableViewController *home = [[BPHomeTableViewController alloc] init];
    [self addOneChildVc:home title:@"首页" imageName:@"noun_home_1144"];

    BPNearTableViewController *near = [[BPNearTableViewController alloc] init];
    [self addOneChildVc:near title:@"附近" imageName:@"noun_map-marker_30476"];

    BPMessageTableViewController *message = [[BPMessageTableViewController alloc] init];
    [self addOneChildVc:message title:@"消息" imageName:@"noun_message_64351"];

    BPProfileTableViewController *proflie = [[BPProfileTableViewController alloc] init];
    [self addOneChildVc:proflie title:@"我的" imageName:@"noun_profile_78763"];
        [super viewDidLoad];

}
/**
 *  添加一个子控制器
 *
 *  @param childVc   子控制器对象
 *  @param title     标题
 *  @param imageName 图标
 */
- (void)addOneChildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName
{

    childVc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
    childVc.title = title;
//    childVc.tabBarItem.title = title;
//    childVc.navigationItem.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    //添加为tabbar控制器的子控制器
    BPNavigationController *nav = [[BPNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}
@end
