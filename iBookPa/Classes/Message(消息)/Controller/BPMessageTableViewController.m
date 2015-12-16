//
//  BPMessageTableViewController.m
//  iBookPa_Ver_0.2
//
//  Created by 鄂鸿桢 on 15/12/4.
//  Copyright © 2015年 ehongzhen. All rights reserved.
//

#import "BPMessageTableViewController.h"

@interface BPMessageTableViewController ()

@end

@implementation BPMessageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem  = [UIBarButtonItem itemWithImageName:@"icon-mainview-location" highlightImageName:@"icon-mainview-location-highlight" target:self action:@selector(locationPosition) event:@" 定位"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"消息测试数据----%ld", (long)indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *newVc = [[UIViewController alloc] init];
    newVc.view.backgroundColor = [UIColor redColor];
    newVc.title = @"新控制器";
    newVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:newVc animated:YES];
}

- (void)locationPosition
{
    NSLog(@"用户要定位");
}

@end
