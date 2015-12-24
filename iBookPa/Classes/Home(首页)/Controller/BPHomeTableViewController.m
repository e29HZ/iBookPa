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

@property (strong, nonatomic) NSMutableArray *statuses;
//@property (nonatomic, copy) NSString *userID;

@property (nonatomic, strong) NSString *statusCategory;

//@property (strong, nonatomic) NSArray *users;
@end

@implementation BPHomeTableViewController


#pragma mark - 懒加载
- (NSMutableArray *)statuses
{
    if (_statuses == nil) {
        _statuses = [NSMutableArray array];
    }
    return _statuses;
}
//- (NSArray *)bpusers
//{
//    if ( _users == nil) {
//        //1.获取全路径
//        NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"home.plist" ofType:nil];
//        //2.根据去路径加载数据
//        NSArray *dictArray = [NSArray arrayWithContentsOfFile:fullPath];
//        //3.字典转模型
//        NSMutableArray  *models = [NSMutableArray arrayWithCapacity:dictArray.count];
//        for (NSDictionary *dict in dictArray) {
//            BPUser *user = [BPUser userWithDict:dict];
//            [models addObject:user];
//        }
//        self.users = [models copy];
//    }
//    return _users;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏按钮
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"icon-mainview-create" highlightImageName:@"icon-mainview-create-highlight" target:self action:@selector(createActivity) event:@" 发布"];
    self.navigationItem.leftBarButtonItem  = [UIBarButtonItem itemWithImageName:@"icon-mainview-location" highlightImageName:@"icon-mainview-location-highlight" target:self action:@selector(locationPosition) event:@" 定位"];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 210;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1.创建cell
    BPHomeTableViewCell *cell = [BPHomeTableViewCell cellWithTableView:tableView];
    
    //2.设置数据
    AVQuery *query = [AVQuery queryWithClassName:@"Activities"];
    //    [query whereKey:@"objectId" notEqualTo:@"0"];
    BPLog(@"%@",query);
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // 检索成功
            NSLog(@"Successfully retrieved %lu posts.", (unsigned long)objects.count);
        } else {
            // 输出错误信息
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
    AVObject *activities = [query getObjectWithId:@"565690ce60b20fc9af96d9a0"];
    BPStatus *status = [[BPStatus alloc] init];
    status.title = [activities objectForKey:@"title"];
    status.remark = [activities objectForKey:@"remark"];
    status.place = [activities objectForKey:@"place"];
    status.target = (int)[activities objectForKey:@"target"];
    status.endTime = [activities objectForKey:@"endTime"];
    status.type = (NSNumber *)[activities objectForKey:@"type"];
    BPLog(@"%@",status.type);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // 为日期格式器设置格式字符串
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    // 使用日期格式器格式化日期、时间
    NSString *endTime = [dateFormatter stringFromDate:status.endTime];
    
    AVObject *avUser = [activities objectForKey:@"owner"];
    BPUser *owner = [[BPUser alloc] init];
    NSString *objID = avUser.objectId;
    AVQuery *avQuery = [AVQuery queryWithClassName:@"_User"];
    AVObject *auser = [avQuery getObjectWithId:objID];
    owner.nickname = [auser objectForKey:@"nickname"];
    owner.avatarUrl = [auser objectForKey:@"avatarUrl"];
    owner.gender = (NSNumber *)[auser objectForKey:@"gender"];
    owner.birth = [auser objectForKey:@"birth"];
    NSDateFormatter *ageDateFormatter = [[NSDateFormatter alloc] init];
    // 为日期格式器设置格式字符串
    [ageDateFormatter setDateFormat:@"yyyy"];
    // 使用日期格式器格式化日期、时间
    NSString *brithDate = [ageDateFormatter stringFromDate:owner.birth];
    int brithInt = [brithDate intValue];
    int ageInt = 2016 - brithInt;
    NSString *age = [NSString stringWithFormat:@"%d", ageInt];
    [cell.sexBtn setTitle:age forState:UIControlStateNormal];
    
    BPLog(@"%@", owner.gender);
    owner.birth = [auser objectForKey:@"brith"];
    cell.topicLabel.text = status.remark;
    if ([owner.gender isEqual: [NSNumber numberWithInt:1]]) {
        [cell.sexBtn setBackgroundColor:[UIColor blueColor]];
    }
    else if ([owner.gender isEqual: [NSNumber numberWithInt:2] ])
    {
        [cell.sexBtn setBackgroundColor:[UIColor redColor]];
    }
    else{
        [cell.sexBtn setBackgroundColor:[UIColor yellowColor]];
    }
    cell.remarkLabel.text =status.title;
    cell.placeLabel.text = status.place;
    /**
     *  对象,15007 仅限男生，15008 仅限女生，15009 男女不限
     */
    if (status.target == 15007) {
        cell.targetLabel.text = @"仅限男生";
    }
    else if(status.target == 15008)
    {
        cell.targetLabel.text = @"仅限男生";
    }
    else
    {
        cell.targetLabel.text = @"男女不限";
    }
    
    cell.endtimeLabel.text = endTime;
    
    if ([status.type  isEqual: [NSNumber numberWithInt:15001]]) {
        cell.typeLabel.text = [BPStatus statusCategoryNameStringWithStatusCategory:BPStatusCategoryRead];
    }
    else if ([status.type  isEqual: [NSNumber numberWithInt:15002]])
    {
        cell.typeLabel.text = [BPStatus statusCategoryNameStringWithStatusCategory:BPStatusCategoryStudy];
    }
    else if ([status.type  isEqual: [NSNumber numberWithInt:15003]])
    {
        cell.typeLabel.text = [BPStatus statusCategoryNameStringWithStatusCategory:BPStatusCategoryFindFriend];
    }
    else if ([status.type  isEqual: [NSNumber numberWithInt:15004]])
    {
        cell.typeLabel.text = [BPStatus statusCategoryNameStringWithStatusCategory:BPStatusCategoryExchangeBooks];
    }
    else if ([status.type  isEqual: [NSNumber numberWithInt:15005]])
    {
        cell.typeLabel.text = [BPStatus statusCategoryNameStringWithStatusCategory:BPStatusCategoryAskForBooks];
    }
    else
    {
        cell.typeLabel.text = [BPStatus statusCategoryNameStringWithStatusCategory:BPStatusCategoryAskForTeaching];
    }
    
    
    cell.iconImage.yy_imageURL = [NSURL URLWithString:owner.avatarUrl];
    cell.nicknameLabel.text = owner.nickname;
    //3.返回cell
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
