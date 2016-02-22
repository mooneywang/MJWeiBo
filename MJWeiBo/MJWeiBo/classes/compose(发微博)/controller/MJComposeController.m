//
//  MJComposeController.m
//  MJWeiBo
//
//  Created by 王梦杰 on 16/2/20.
//  Copyright © 2016年 Mooney_wang. All rights reserved.
//

#import "MJComposeController.h"
#import "MJAccountTool.h"
#import "MJAccount.h"
#import "MJTextView.h"
#import "MJComposeToolBar.h"
#import "MJComposePhotosView.h"
#import "MJEmotionKeyboard.h"

@interface MJComposeController () <UITextViewDelegate, MJComposeToolBarDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property(nonatomic ,weak)MJTextView *textView;
@property(nonatomic ,weak)MJComposeToolBar *toolBar;
@property(nonatomic ,weak)MJComposePhotosView *photosView;
//表情键盘
@property(nonatomic ,strong)MJEmotionKeyboard *emotionKeyboard;
@property(nonatomic, assign)BOOL isSwitchingKeyboard;


@end

@implementation MJComposeController

#pragma mark - 懒加载

- (MJEmotionKeyboard *)emotionKeyboard {
    if (_emotionKeyboard == nil) {
        _emotionKeyboard = [[MJEmotionKeyboard alloc] init];
        _emotionKeyboard.width = self.view.width;
        //标准键盘高度是216
        _emotionKeyboard.height = 216;
    }
    return _emotionKeyboard;
}


#pragma mark - 初始化设置方法
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //设置导航栏
    [self setupNav];
    
    //设置输入框
    [self setupTextView];
    
    //设置键盘工具条
    [self setupComposeToolBar];
    
    //设置相册
    [self setupPhotosView];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}

- (void)setupNav{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeBtnClick)];
    
//    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightBtn.size = CGSizeMake(50, 30);
//    //文字右对齐
//    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    [rightBtn setTitle:@"发送" forState:UIControlStateNormal];
//    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    [rightBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
//    [rightBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
//    [rightBtn addTarget:self action:@selector(sendBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
//    rightBtn.enabled = NO;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendBtnClick)];
    self.navigationItem.rightBarButtonItem.enabled = NO;

    
    //获得账号
    MJAccount *account = [MJAccountTool account];
    if (account.name) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.width = 200;
        titleLabel.height = 44;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.numberOfLines = 0;
        NSString *str = [NSString stringWithFormat:@"发微博\n%@",account.name];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(0, 3)];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[str rangeOfString:account.name]];
        titleLabel.attributedText = attrStr;
        self.navigationItem.titleView = titleLabel;
    }else{
        self.navigationItem.title = @"发微博";
    }
    
    
}

/**
 *  设置文本框
 */
- (void)setupTextView{
    MJTextView *textView = [[MJTextView alloc] init];
    textView.placeholder = @"发现新鲜事...";
    textView.font = [UIFont systemFontOfSize:15];
    textView.frame = self.view.bounds;
    textView.alwaysBounceVertical = YES;// default NO. if YES and bounces is YES, even if content is smaller than bounds, allow drag vertically
    self.textView = textView;
    textView.delegate = self;
    [self.view addSubview:textView];
    
    //监听文本框文字
    //self监听textView发出的UITextViewTextDidChangeNotification通知，监听到后执行textDidChange方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    
}

/**
 *  设置工具条
 */
- (void)setupComposeToolBar {
    MJComposeToolBar *toolBar = [[MJComposeToolBar alloc] init];
    CGFloat toolBarH = 40;
    toolBar.frame = CGRectMake(0, self.view.height - toolBarH, self.view.width, toolBarH);
    [self.view addSubview:toolBar];
    self.toolBar = toolBar;
    toolBar.delegate = self;
    
    //监听键盘Frame发生改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

/**
 *  设置相册
 */
- (void)setupPhotosView{
    MJComposePhotosView *photosView = [[MJComposePhotosView alloc] init];
    self.photosView = photosView;
    [self.textView addSubview:photosView];
    photosView.y = 130;
    photosView.width = self.view.width;
    photosView.height = self.view.height;
    
}

/**
 *  textView文本发生改变
 */
- (void)textDidChange {
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}


/**
 *  关闭按钮点击事件
 */
- (void)closeBtnClick{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//URL: https://api.weibo.com/2/statuses/update.json
//  参数:
// 	status true string 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。*/
//	pic false binary 微博的配图。*/
//access_token true string*/
// 1.请求管理者
//AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//
// 2.拼接请求参数
//NSMutableDictionary *params = [NSMutableDictionary dictionary];
//params[@"access_token"] = [HWAccountTool account].access_token;
//params[@"status"] = self.textView.text;
//
// 3.发送请求
//[mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
//    [MBProgressHUD showSuccess:@"发送成功"];
//} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//    [MBProgressHUD showError:@"发送失败"];
//}];
//
//4.dismiss
//[self dismissViewControllerAnimated:YES completion:nil];

/**
 *  发微博
 */
- (void)sendBtnClick{
    //有图片就发送有图片的微博，无图片发送纯文本微博
    if (self.photosView.photos.count) {
        [self sendStatusWithImage];
    }else{
        [self sendStatusWithoutImage];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  发送没有图片的微博
 */
- (void)sendStatusWithoutImage {
    //发布一条微博的API：https://api.weibo.com/2/statuses/update.json
    //参数：status 要发布的微博
    //1.请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.拼接参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [MJAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    //3.发送请求
    [manager POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];

}

/**
 *  发送有图片的微博
 */
- (void)sendStatusWithImage {
    //发布带图片微博的API：https://upload.api.weibo.com/2/statuses/upload.json
    //参数：status 要发布的微博
    //pic 	true 	binary 	要上传的图片，仅支持JPEG、GIF、PNG格式，图片大小小于5M。
    //1.请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.拼接参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [MJAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    
    /**
     *  需要上传文件的网络请求
     */
    [manager POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        UIImage *image = [self.photosView.photos firstObject];
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"test.jpg" mimeType:@"image/jpeg"];
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 键盘Frame发生改变通知
- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    if (self.isSwitchingKeyboard) return;
    /**
     notification:
     {name = UIKeyboardWillChangeFrameNotification; userInfo = {
     //键盘弹出\隐藏动画的执行节奏（先快后慢，匀速）
     UIKeyboardAnimationCurveUserInfoKey = 7;
     //键盘弹出/隐藏动画持续时间
     UIKeyboardAnimationDurationUserInfoKey = "0.4";
     UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {320, 253}}";
     UIKeyboardCenterBeginUserInfoKey = "NSPoint: {160, 1009.5}";
     UIKeyboardCenterEndUserInfoKey = "NSPoint: {160, 441.5}";
     UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 883}, {320, 253}}";
     //键盘弹出/隐藏后的Frame
     UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 315}, {320, 253}}";
     }}
     */
    NSDictionary *userInfo = notification.userInfo;
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //执行动画
    [UIView animateWithDuration:duration animations:^{
        // 工具条的Y值 == 键盘的Y值 - 工具条的高度
        if (keyboardF.origin.y > self.view.height) { // 键盘的Y值已经远远超过了控制器view的高度
            self.toolBar.y = self.view.height - self.toolBar.height;
        } else {
            self.toolBar.y = keyboardF.origin.y - self.toolBar.height;
        }
        
    }];
}

#pragma mark - UITextViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //用户一拖拽屏幕就退出键盘
    [self.view endEditing:YES];
}

#pragma mark - MJComposeToolBarDelegate
- (void)composeToolBar:(MJComposeToolBar *)toolBar didClickButton:(MJComposeToolBarButtonType)type {
    switch (type) {
        case MJComposeToolBarButtonTypeCamera:
            [self openCamera];
            break;
        case MJComposeToolBarButtonTypeAlbumn:
            [self openAlbumn];
            break;
        case MJComposeToolBarButtonTypeMention:
            NSLog(@"@");
            break;
        case MJComposeToolBarButtonTypeTrend:
            NSLog(@"#");
            break;
        case MJComposeToolBarButtonTypeEmotion:
            //切换键盘
            [self switchKeyboard];
            break;
            
        default:
            break;
    }
}

#pragma mark - 私有方法
/**
 *  打开相机
 */
- (void)openCamera {

    [self openImagePickerControllerWithSourceType:UIImagePickerControllerSourceTypeCamera];
}

/**
 *  打开相册
 */
- (void)openAlbumn {
    
    [self openImagePickerControllerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)openImagePickerControllerWithSourceType:(UIImagePickerControllerSourceType)type {
    //如果没有权限则返回
    if (![UIImagePickerController isSourceTypeAvailable:type]) return;
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.delegate = self;
    pickerController.sourceType = type;//设置为从照相机获取
    [self.navigationController presentViewController:pickerController animated:YES completion:nil];
}

/**
 *  切换键盘
 */
- (void)switchKeyboard {
    //该属性表示正在切换键盘
    self.isSwitchingKeyboard = YES;
    //如果是系统自带的键盘，则切换为表情键盘
    //如果是系统自带的键盘,那么self.textView.inputView == nil
    if (self.textView.inputView == nil) {
        self.textView.inputView = self.emotionKeyboard;
        //工具条下移
        self.toolBar.y = self.view.height - self.emotionKeyboard.height - self.toolBar.height;
        //显示表情图片
        self.toolBar.isEmotionKeyboard = YES;
    }else {
        self.textView.inputView = nil;
        //工具条上移
        self.toolBar.y = self.view.height - 253 - self.toolBar.height;
        //显示键盘图片
        self.toolBar.isEmotionKeyboard = NO;
    }
    //切换键盘的时候需要先让原来的键盘下去，然后新的键盘再上来
    [self.textView resignFirstResponder];
    
    //这边还有一个细节，如果正在切换键盘，那么，工具条要保持原来的位置不动，所以我们定义一个属性，如果正在切换键盘，那么键盘Frame改变通知处的代码不执行
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.textView becomeFirstResponder];
        self.isSwitchingKeyboard = NO;
    });
    
}

#pragma mark - UIImagePickerControllerDelegate
/**
 *  当选择完图片之后调用（拍完照或者选择完图片）
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //控制器退出
    [picker dismissViewControllerAnimated:YES completion:nil];
    //info中包含了所需要的图片
    UIImage *selImage = info[UIImagePickerControllerOriginalImage];
    [self.photosView addPhoto:selImage];
}


@end
