//
//  BPLogViewController.m
//  iBookPa_Ver_0.2
//
//  Created by 鄂鸿桢 on 15/12/7.
//  Copyright © 2015年 ehongzhen. All rights reserved.
//

#import "BPLogViewController.h"
#import "BPTabBarViewController.h"
#import "BPSignViewController.h"

@interface BPLogViewController ()
/**
 *  帐号
 */
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
/**
 *  密码
 */
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
/**
 *  记住密码
 */
- (IBAction)rememberPwd;
/**
 *  自动登录
 */
- (IBAction)autoLogin;
/**
 *  登录
 */
- (IBAction)login;
/**
 *  注册
 */

- (IBAction)signupBtn:(id)sender;

@end

@implementation BPLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}



- (IBAction)rememberPwd {
    BPLog(@"记住密码");
}

- (IBAction)autoLogin
{
    BPLog(@"自动登录");
}


- (IBAction)login {
    NSString *bpusername = self.accountTextField.text;
    NSString *bppwd = self.pwdTextField.text;
    
    [AVUser logInWithUsernameInBackground:bpusername password:bppwd block:^(AVUser *user, NSError *error) {
        //        MBProgressHUD *mbploging = [[MBProgressHUD alloc] init];
        //        [mbploging show:YES];
        if ([self filterError:error]) {
            BPLog(@"登录成功 %@",user);
            // 切换控制器到主界面
            BPTabBarViewController *vc = [[BPTabBarViewController alloc] init];
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            window.rootViewController = vc;
        }
        else
        {
            BPLog(@"登录失败");
        }
    }];
}

-(BOOL)filterError:(NSError *)error{
    if (error) {
        return NO;
    } else {
        return YES;
    }
}

- (IBAction)signupBtn:(id)sender {
    
    BPLog(@"用户注册");
    // 切换控制器
    BPSignViewController *signVc = [[BPSignViewController alloc] init];
    [self presentViewController:signVc animated:YES completion:nil];
    signVc.title = @"注册";
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
