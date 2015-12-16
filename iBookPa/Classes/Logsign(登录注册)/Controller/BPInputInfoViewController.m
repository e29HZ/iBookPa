//
//  BPInputInfoViewController.m
//  iBookPa_Ver_0.2
//
//  Created by 鄂鸿桢 on 15/12/7.
//  Copyright © 2015年 ehongzhen. All rights reserved.
//

#import <MobileCoreServices/MobileCoreServices.h>
#import "BPInputInfoViewController.h"
#import "BPTabBarViewController.h"




@interface BPInputInfoViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

/**
 *  设置头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;

/**
 *  性别男
 */
@property (weak, nonatomic) IBOutlet UIButton *femaleBtn;
- (IBAction)onClickMaleBtn:(id)sender;
/**
 *  性别女
 */
@property (weak, nonatomic) IBOutlet UIButton *maleBtn;

- (IBAction)onClickFemaleBtn:(id)sender;

/**
 *  昵称
 */
@property (weak, nonatomic) IBOutlet UITextField *nickName;
/**
 *  生日
 */
@property (weak, nonatomic) IBOutlet UITextField *brith;

/**
 *  个性签名
 */
@property (weak, nonatomic) IBOutlet UITextField *signature;

@property (weak, nonatomic) NSData *fileData;
@property (weak, nonatomic) NSData *imageData;
@property (weak, nonatomic) AVFile *avatarFile;


@end

@implementation BPInputInfoViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //创建时间选择器
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    //设置默认时间
    NSDate *sdate = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:0];
    //初始化时间选择器
    [datePicker setDate:sdate];
    datePicker.frame = CGRectMake(0, 44, 375, 280);
    self.brith.inputView = datePicker;
    
    NSLocale *locale = [datePicker locale];
    [locale objectForKey:@"zh_CN"];
    datePicker.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    NSDate *selected = datePicker.date;
    // 创建一个日期格式器
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // 为日期格式器设置格式字符串
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    // 使用日期格式器格式化日期、时间
    NSString *destDateString = [dateFormatter stringFromDate:selected];
    self.brith.text = destDateString;
    [datePicker addTarget:self action:@selector(selectDay:) forControlEvents:UIControlEventValueChanged];
    
    //将imageView设为可点击
    self.avatarImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectIcon)];
    [self.avatarImage addGestureRecognizer:singleTap];
}

- (void)selectIcon
{
    
    BPLog(@"设置头像");
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    //设置图片源(相簿)
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    //设置代理
    picker.delegate = self;
    //设置可以编辑
    picker.allowsEditing = YES;
    //打开拾取器界面
    [self presentViewController:picker animated:YES completion:nil];
    
}
#pragma UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeImage]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        
        [self performSelector:@selector(saveImage:)  withObject:image afterDelay:0.5];
    }
    else if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeMovie]) {
        NSString *videoPath = (NSString *)[[info objectForKey:UIImagePickerControllerMediaURL] path];
        self.fileData = [NSData dataWithContentsOfFile:videoPath];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  保存头像
 *
 *  @param image 被点击的image
 */
- (void)saveImage:(UIImage *)image
{
    //保存头像
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imageFilePath = [documentsDirectory stringByAppendingString:@"userAvatar.png"];
    NSLog(@"imageFile->>%@",imageFilePath);
    
    success = [fileManager fileExistsAtPath:imageFilePath];
    if(success) {
        success = [fileManager removeItemAtPath:imageFilePath error:&error];
    }
    UIImage *smallImage=[self scaleFromImage:image toSize:CGSizeMake(100.0f, 100.0f)];//将图片尺寸改为100*100
    [UIImageJPEGRepresentation(smallImage, 1.0f) writeToFile:imageFilePath atomically:YES];//写入文件
    UIImage *selfPhoto = [UIImage imageWithContentsOfFile:imageFilePath];//读取图片文件
    self.imageData = [NSData dataWithContentsOfFile:imageFilePath];
    self.avatarImage.image = selfPhoto;
    BPLog(@"%@",self.avatarImage.image);
    
    
    
}

// 改变图像的尺寸，方便上传服务器
- (UIImage *) scaleFromImage: (UIImage *)image toSize: (CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - 自定义brith替换键盘
/**
 *  设置时间格式并显示到brith上
 *
 *  @param textField 当前text
 */
- (void)selectDay:(id *)sender
{
    
    UIDatePicker *datePicker = (UIDatePicker *)self.brith.inputView;
    NSDate *selected = datePicker.date;
    
    BPLog(@"brithday");
    
    // 创建一个日期格式器
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    // 为日期格式器设置格式字符串
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    // 使用日期格式器格式化日期、时间
    self.brith.text = [dateFormatter stringFromDate:selected];
    
}


/**
 *  完善信息
 */
- (IBAction)signUpComplete:(id)sender {
    
    BPUser *currentUser = [BPUser currentUser];
    UIDatePicker *datePicker = (UIDatePicker *)self.brith.inputView;
    NSDate *selected = datePicker.date;
    
    if (currentUser) {
        BPLog(@"当前用户 %@ , 用户名 %@",currentUser, currentUser.username);
        if (self.maleBtn.tag == 1) {
            NSNumber *gender = [[NSNumber alloc] initWithInt:1];
            [currentUser setObject:gender forKey:@"gender"];
            
        }
        else if(self.femaleBtn.tag == 1)
        {
            NSNumber *gender = [[NSNumber alloc] initWithInt:0];
            [currentUser setObject:gender forKey:@"gender"];
            
        }
        [currentUser setObject:self.nickName.text forKey:@"nickname"];
        [currentUser setObject:self.signature.text forKey:@"signature"];
        [currentUser setObject:selected forKey:@"brith"];
        NSData *imageData = UIImagePNGRepresentation(self.avatarImage.image);
        AVFile *imageFile = [AVFile fileWithName:@"userAvatar.png" data:imageData];
        [imageFile save];
        [currentUser setObject:imageFile.url forKey:@"avatarUrl"];
        
        [currentUser save];
        
        //        切换控制器
        BPTabBarViewController *tabBarVc = [[BPTabBarViewController alloc] init];
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        window.rootViewController = tabBarVc;
        
    }
    
    BPTabBarViewController *tabBarVc = [[BPTabBarViewController alloc] init];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = tabBarVc;
}

- (IBAction)onClickMaleBtn:(id)sender {
    self.maleBtn.tag = 1;
    self.femaleBtn.tag = 2;
    self.maleBtn.selected = YES;
    self.femaleBtn.selected = NO;
    
}


- (IBAction)onClickFemaleBtn:(id)sender {
    self.femaleBtn.tag = 1;
    self.maleBtn.tag = 2;
    self.femaleBtn.selected = YES;
    self.maleBtn.selected = NO;
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


@end
