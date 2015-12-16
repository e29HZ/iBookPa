//
//  BPSignViewController.m
//  iBookPa_Ver_0.2
//
//  Created by 鄂鸿桢 on 15/12/7.
//  Copyright © 2015年 ehongzhen. All rights reserved.
//

#import "BPSignViewController.h"
#import "BPInputInfoViewController.h"
#import "BPUser.h"

@interface BPSignViewController ()

/**
 *  手机号
 */
@property (weak, nonatomic) IBOutlet UITextField *cellPhone;
/**
 *  验证码
 */
@property (weak, nonatomic) IBOutlet UITextField *identifyingCode;
/**
 *  发送验证码按钮
 */
- (IBAction)sendIdCodeBtn;
/**
 *  密码
 */
@property (weak, nonatomic) IBOutlet UITextField *signPwd;
/**
 *  确认密码
 */
@property (weak, nonatomic) IBOutlet UITextField *confirmPwd;
/**
 *  注册按钮
 */
- (IBAction)signUpBtn;

@end

@implementation BPSignViewController

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)sendIdCodeBtn{
    
    NSString *phoneNumber = self.cellPhone.text;
    
    [AVOSCloud requestSmsCodeWithPhoneNumber:phoneNumber appName:@"书趴" operation:@"注册" timeToLive:10 callback: ^(BOOL succeeded, NSError *error) {
        if ([self filterError:error]) {
            BPLog(@"短信发送成功");
            
        }
        else {
            BPLog(@"短信发送失败");
        }
    }];
    
}


-(BOOL)filterError:(NSError *)error{
    if (error) {
        BPLog(@"%@",error);
        return NO;
    } else {
        return YES;
    }
}



- (IBAction)signUpBtn {
    
    BPLog(@"完善信息");
    
    
    NSString *phoneNumber = self.cellPhone.text;
    NSString *confirmPwd = self.confirmPwd.text;
    NSString *smsCode = self.identifyingCode.text;
    BPUser *bpuser = [[BPUser alloc] init];
    AVUser *tempuser = [AVUser user];
    bpuser.avuser = tempuser;
    //    判断短信验证码是否正确
    [AVOSCloud verifySmsCode:smsCode mobilePhoneNumber:phoneNumber callback:^(BOOL succeeded, NSError *error) {
        if ([self filterError:error]) {
            BPLog(@"验证成功，手机号码为 %@，验证码为 %@", phoneNumber, smsCode);
            
            //上传用户账号和密码到服务器
            
            bpuser.username = phoneNumber;
            bpuser.password = confirmPwd;
            [bpuser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if ([self filterError:error]) {
                    BPLog(@"用户注册成功 %@",bpuser);
                    BPLog(@"当前用户 %@",bpuser.username);
                }
                [AVUser logInWithUsernameInBackground:phoneNumber password:confirmPwd block:^(AVUser *user, NSError *error) {
                    if ([self filterError:error]) {
                        BPLog(@"登录成功 %@",user);
                    }
                }];
                //切换控制器
                
                BPInputInfoViewController *inputInfoVc = [[BPInputInfoViewController alloc] init];
                
                UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:inputInfoVc];
                
                [self presentViewController:nv animated:YES completion:nil];
            }];
        }
    }];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
