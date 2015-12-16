//
//  BPHomeTableViewController.m
//  iBookPa_Ver_0.2
//
//  Created by 鄂鸿桢 on 15/12/4.
//  Copyright © 2015年 ehongzhen. All rights reserved.
//

#import "BPHomeTableViewController.h"
#import "BPStatus.h"
#import "BPUser.h"
#import "BPCreateActivityTableViewController.h"
#import "BPHomeTableViewCell.h"

@interface BPHomeTableViewController ()<UIAlertViewDelegate,UIActionSheetDelegate>
/**
 *  在用户点击右上角之后弹出询问种类的 actionSheet
 */
@property (nonatomic, strong) UIAlertController *askAlertSheet;

@property (strong, nonatomic) NSArray *statuss;
@property (strong, nonatomic) NSArray *users;
@end

@implementation BPHomeTableViewController


#pragma mark - 懒加载
- (NSArray *)statuss
{
    if (_statuss == nil) {
        //1.获取全路径
        NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"home.plist" ofType:nil];
        //2.根据去路径加载数据
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:fullPath];
        //3.字典转模型
        NSMutableArray  *models = [NSMutableArray arrayWithCapacity:dictArray.count];
        for (NSDictionary *dict in dictArray) {
            BPStatus *status = [BPStatus statusWithDict:dict];
            [models addObject:status];
        }
        self.statuss = [models copy];
    }
    return _statuss;
}
- (NSArray *)bpusers
{
    if ( _users == nil) {
        //1.获取全路径
        NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"home.plist" ofType:nil];
        //2.根据去路径加载数据
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:fullPath];
        //3.字典转模型
        NSMutableArray  *models = [NSMutableArray arrayWithCapacity:dictArray.count];
        for (NSDictionary *dict in dictArray) {
            BPUser *user = [BPUser userWithDict:dict];
            [models addObject:user];
        }
        self.users = [models copy];
    }
    return _users;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏按钮
   
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"icon-mainview-create" highlightImageName:@"icon-mainview-create-highlight" target:self action:@selector(createActivity) event:@" 发布"];
    self.navigationItem.leftBarButtonItem  = [UIBarButtonItem itemWithImageName:@"icon-mainview-location" highlightImageName:@"icon-mainview-location-highlight" target:self action:@selector(locationPosition) event:@" 定位"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return  20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    //1.创建cell
//    BPHomeTableViewCell *homeTableCell = [BPHomeTableViewCell cellWithTableView:tableView];
//    
//    //2.设置数据
//    BPStatus *status = self.statuss[indexPath.row];
//    homeTableCell.status = status;
//    
//    //3.返回cell
//    return homeTableCell;
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"首页测试数据----%ld", (long)indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"%@", self.navigationController);
    UIViewController *newVc = [[UIViewController alloc] init];
    newVc.view.backgroundColor = [UIColor redColor];
    newVc.title = @"新控制器";
    newVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:newVc animated:YES];
}

- (void)createActivity
{
    NSLog(@"用户发起活动");
    [self presentViewController:self.askAlertSheet animated:YES completion:nil];
    
}

- (void)locationPosition
{
    NSLog(@"用户要定位");
}

- (UIAlertController *)askAlertSheet {
    if (_askAlertSheet == nil) {
        _askAlertSheet = [UIAlertController alertControllerWithTitle:@"请选择发布的种类" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        
        // 向 actionSheet 添加动作
        [self addAlertAction:_askAlertSheet WithName:@"陪看书" andCategory:BPStatusCategoryRead];
        [self addAlertAction:_askAlertSheet WithName:@"去自习" andCategory:BPStatusCategoryStudy];
        [self addAlertAction:_askAlertSheet WithName:@"找书友" andCategory:BPStatusCategoryFindFriend];
        [self addAlertAction:_askAlertSheet WithName:@"换本书" andCategory:BPStatusCategoryExchangeBooks];
        [self addAlertAction:_askAlertSheet WithName:@"求教材" andCategory:BPStatusCategoryAskForBooks];
        [self addAlertAction:_askAlertSheet WithName:@"求补课" andCategory:BPStatusCategoryAskForTeaching];
        
        [_askAlertSheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        
    }
    
    return _askAlertSheet;
}

/**
 *  向 actionVC 中添加一个 alertAction
 *
 *  @param alertViewController alertVC
 *  @param name                标题
 *  @param category            活动的种类
 */
- (void)addAlertAction:(UIAlertController *)alertViewController WithName:(NSString *)name andCategory:(BPStatusCategory)category {
    
    [alertViewController addAction:[UIAlertAction actionWithTitle:name style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // 创建发布新鲜事儿的 ViewController
  
        BPCreateActivityTableViewController *createActivityvc = [[BPCreateActivityTableViewController alloc] init];
        createActivityvc.statusCategory = [BPStatus statusCategoryNameStringWithStatusCategory:category];
        
        UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:createActivityvc];
        
        [self presentViewController:nv animated:YES completion:nil];
    }]];
}


@end
