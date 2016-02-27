//
//  BPCreateActivityTableViewController.m
//  iBookPa_Ver_0.2
//
//  Created by 鄂鸿桢 on 15/12/5.
//  Copyright © 2015年 ehongzhen. All rights reserved.
//

#import "BPCreateActivityTableViewController.h"

@interface BPCreateActivityTableViewController ()

@end

@implementation BPCreateActivityTableViewController

- (void)viewDidLoad {

   
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    // 设置协议，意思就是UITableView类的方法交给了tabView这个对象，让完去完成表格的一些设置操作
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    //把tabView添加到视图之上
    
    [self initNavigationBar];
    //创建头视图
    UITableViewHeaderFooterView *tableViewHeaderFooterView = [[UITableViewHeaderFooterView alloc] init];
    tableViewHeaderFooterView.frame = CGRectMake(0, 0, 400, 200);
    
    tableViewHeaderFooterView.textLabel.text = @"dhsadkas";
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"创建活动测试数据----%ld", (long)indexPath.row];
    return cell;
}

/**
 *  为导航栏创建左右按钮
 */
- (void)initNavigationBar {
   
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftButton setTitle:@"取消" forState:UIControlStateNormal];
    [leftButton sizeToFit];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    [leftButton addTarget:self action:@selector(leftBarButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [rightButton setTitle:@"发布" forState:UIControlStateNormal];
    [rightButton sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    [rightButton addTarget:self action:@selector(rightBarButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.title = @"新活动";
}

/**
 *  点击了左上角的取消按钮
 */
- (void)leftBarButtonClicked {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  点击了右上角的发布按钮
 */
- (void)rightBarButtonClicked {
    // 做一下检查
//    if ([self checkInfoIsOk]) {
//        // 上传到服务器，然后 dismiss
//        
//        // 刷新一下，在表格顶部刷出自己发布的那一条
//        
//        // TODO: 在这里上传
//        
//    } else {
//        // 提示用户信息填入有误
//    }
    NSLog(@"发布活动");
}


@end
