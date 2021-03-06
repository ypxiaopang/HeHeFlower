//
//  ForgetKeyController.m
//  JulijrP2P
//
//  Created by 韩 立 on 2016/12/25.
//  Copyright © 2016年 聚力金服网络科技有限公司. All rights reserved.
//
//  忘记密码

#import "ForgetKeyController.h"
#import "EditView.h"
#import "InputView.h"
#import "LoginVerityForgetKeyController.h"
#import "NetWorkClient.h"
@interface ForgetKeyController ()<UITextFieldDelegate,NavBarDelegate,HTTPClientDelegate>
{
    NSMutableString *phoneNum;
    NSInteger _typeNum;				//请求类型
}
@property (nonatomic,strong)UITextField *verifyInput;
@property (nonatomic,strong)UITextField *phoneNumberTf;
@property (nonatomic,strong)UIButton *doneBtn;
@property (nonatomic, strong)UIButton *getVerifyNum;
@property (nonatomic,copy)   NSString *userId;
@end

@implementation ForgetKeyController

#pragma mark - 控制器视图生命周期
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [NetWorkClient sharedInstance].delegate = self;

    [UIApplication sharedApplication].statusBarHidden = NO;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self initView];
}

#pragma mark - 视图初始化
- (void)initView
{
    NavBar *navBar = [[NavBar alloc]initWithTitle:@"忘记密码"];
    navBar.delegate = self;
    [self.view addSubview:navBar];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [NetWorkClient sharedInstance].delegate = self;

    
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, MSWIDTH, 20)];
    backImage.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1];
    [self.view addSubview:backImage];
    
    UILabel *phoneInputNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, NAVBAR_HEIGHT+20, 60, ITHIGHT)];
    phoneInputNameLabel.text = @"手机号";
    phoneInputNameLabel.textColor = [UIColor blackColor];
    phoneInputNameLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:12];
    [self.view addSubview:phoneInputNameLabel];
    
    _phoneNumberTf = [[UITextField alloc]initWithFrame:CGRectMake(70, NAVBAR_HEIGHT+20, MSWIDTH-70, ITHIGHT)];
    _phoneNumberTf.placeholder = @"请输入您的手机号码";
    _phoneNumberTf.font = [UIFont fontWithName:@"STHeitiSC-Light" size:12];
    _phoneNumberTf.textColor = [UIColor colorWithRed:91/255.0 green:91/255.0 blue:91/255.0 alpha:1];
    _phoneNumberTf.keyboardType = UIKeyboardTypeNumberPad;
    _phoneNumberTf.delegate = self;
    [_phoneNumberTf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_phoneNumberTf];
    
    
    UIImageView *backImage_1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, NAVBAR_HEIGHT+20+ITHIGHT, MSWIDTH, 10)];
    backImage_1.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1];
    [self.view addSubview:backImage_1];
    
    UILabel *verifyName = [[UILabel alloc] initWithFrame:CGRectMake(10, NAVBAR_HEIGHT+30+ITHIGHT, 60, ITHIGHT)];
    verifyName.text = @"验证码";
    verifyName.textColor = [UIColor blackColor];
    verifyName.font = [UIFont fontWithName:@"STHeitiSC-Light" size:12];
    [self.view addSubview:verifyName];
    
    _verifyInput = [[UITextField alloc]initWithFrame:CGRectMake(70, NAVBAR_HEIGHT+30+ITHIGHT, MSWIDTH-144, ITHIGHT)];
    _verifyInput.placeholder = @"请输入6位数字验证码";
    _verifyInput.font = [UIFont fontWithName:@"STHeitiSC-Light" size:12];
    _verifyInput.textColor = [UIColor colorWithRed:91/255.0 green:91/255.0 blue:91/255.0 alpha:1];
    _verifyInput.keyboardType = UIKeyboardTypeNumberPad;
    _verifyInput.delegate = self;
    [_verifyInput addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_verifyInput];
    
    //获取手机验证码按钮
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetBtn.frame = CGRectMake(MSWIDTH-74, NAVBAR_HEIGHT+30+ITHIGHT, 65, ITHIGHT);
    [forgetBtn setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(VerifyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [forgetBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:12];
    _getVerifyNum = forgetBtn;
    [self.view addSubview:forgetBtn];
    
    
    UIImageView *backImage_2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, ITHIGHT * 2 +NAVBAR_HEIGHT +30, MSWIDTH, 10)];
    backImage_2.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1];
    [self.view addSubview:backImage_2];
    
    _doneBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, ITHIGHT * 2 +NAVBAR_HEIGHT +50, MSWIDTH-20, 55)];
    [_doneBtn setTitle:@"下一步" forState:UIControlStateNormal];
    _doneBtn.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:15];
    [_doneBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn"] forState:UIControlStateNormal];
    [_doneBtn addTarget:self action:@selector(doneReSet) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_doneBtn];
    
    
    
    UILabel *bottomFirstLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, MSHIGHT-50, MSWIDTH-20, 17.5)];
    bottomFirstLabel.text = @"如有疑问，请联系客服：400-885-9037";
    bottomFirstLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:12];
    bottomFirstLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:bottomFirstLabel];
    
    UILabel *bottomSecondLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, MSHIGHT-27.5, MSWIDTH-20, 17.5)];
    bottomSecondLabel.text = @"8:30 - 20:00 (工作日)";
    bottomSecondLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:10];
    bottomSecondLabel.textColor = [UIColor colorWithRed:72/255.0 green:72/255.0 blue:72/255.0 alpha:1];
    bottomSecondLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:bottomSecondLabel];
}

-(void) requestData{//验证手机号码
    _typeNum =1;
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:@"117" forKey:@"OPT"];
    [parameters setObject:@"" forKey:@"body"];
    [parameters setObject:_phoneNumberTf.text forKey:@"mobile"];
    [parameters setObject:@"FORGOT_LOGINPWD" forKey:@"scene"]; //
    [[NetWorkClient sharedInstance] requestGet:@"app/AppController" withParameters:parameters];
}





/*倒计时*/
- (void)countdown
{
    __block int timeout = 60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [_getVerifyNum setTitle:@"获取验证码" forState:UIControlStateNormal];
                _getVerifyNum.userInteractionEnabled = YES;
                [_getVerifyNum setAlpha:1];
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [_getVerifyNum setTitle:[NSString stringWithFormat:@"%@秒",strTime] forState:UIControlStateNormal];
                _getVerifyNum.userInteractionEnabled = NO;
                [_getVerifyNum setAlpha:0.4];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}



#pragma mark - 获取手机验证码按钮事件触发
/* 获取验证码按钮事件触发，先验证手机是否注册*/
- (void)VerifyBtnClick{
    if (![_phoneNumberTf.text isPhone]) {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
        [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
        [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:71/255.0 green:71/255.0 blue:71/255.0 alpha:0.8888888]];
        [SVProgressHUD setMinimumDismissTimeInterval:3.0];
        [SVProgressHUD showImage:nil status:@"请输入正确的手机号码"];
        return;
    }
    [self requestData];
}
#pragma mark - textfield代理方法
/* 动态视图方法 */
- (void) textFieldDidBeginEditing:(UITextField *)textField
{
}

/* 动态视图方法 */
- ( void )textFieldDidEndEditing:( UITextField *)textField{
    
}

// 实时监测textfield里面内容变化
-(void)textFieldDidChange:(id)sender{
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:@"UITextFieldTextDidChangeNotification"
                                                 object:_verifyInput];
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:@"UITextFieldTextDidChangeNotification"
                                                 object:_phoneNumberTf];
}

#pragma mark - 网络数据回调代理
-(void) startRequest{
    [DejalActivityView activityViewForView:self.view];
}

// 返回成功
-(void) httpResponseSuccess:(NetWorkClient *)client dataTask:(NSURLSessionDataTask *)task didSuccessWithObject:(id)obj{
    NSDictionary *dics = obj;
    DLOG(@"返回的参数如下:%@",dics);
    if ([[NSString stringWithFormat:@"%@",[dics objectForKey:@"code"]] isEqualToString:@"1"]) {
        if (_typeNum == 1) {
            _userId = [NSString stringWithFormat:@"%@",[dics objectForKey:@"userId"]];
            // 是否成功发送验证码
            DLOG(@"msg  -> %@", [obj objectForKey:@"msg"]);
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
            [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
            [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:71/255.0 green:71/255.0 blue:71/255.0 alpha:0.8888888]];
            [SVProgressHUD setMinimumDismissTimeInterval:2.0];
            [SVProgressHUD showImage:nil status:[NSString stringWithFormat:@"%@", [obj objectForKey:@"msg"]]];
            [self countdown];
        }else{
            LoginVerityForgetKeyController *verifyVC = [[LoginVerityForgetKeyController alloc] init];
            verifyVC.userId = _phoneNumberTf.text;
            verifyVC.verifyCodeInHere = _verifyInput.text;
            [self.navigationController pushViewController:verifyVC animated:NO];
        }
    }else {
        DLOG(@"返回失败  msg -> %@",[obj objectForKey:@"msg"]);
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
        [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
        [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:71/255.0 green:71/255.0 blue:71/255.0 alpha:0.8888888]];
        [SVProgressHUD setMinimumDismissTimeInterval:3.0];
        [SVProgressHUD showImage:nil status:[NSString stringWithFormat:@"%@", [obj objectForKey:@"msg"]]];
    }
}



#pragma mark - 下一步按钮事件
- (void)doneReSet{
    if (_verifyInput.text.length != 6) {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
        [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
        [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:71/255.0 green:71/255.0 blue:71/255.0 alpha:0.8888888]];
        [SVProgressHUD setMinimumDismissTimeInterval:3.0];
        [SVProgressHUD showImage:nil status:@"您输入的验证码位数不正确"];
        return;
    }
    if (![_phoneNumberTf.text isPhone]) {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
        [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
        [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:71/255.0 green:71/255.0 blue:71/255.0 alpha:0.8888888]];
        [SVProgressHUD setMinimumDismissTimeInterval:3.0];
        [SVProgressHUD showImage:nil status:@"请输入正确的手机号码"];
        return;
    }
    if (_userId) {
        _typeNum =2;
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        [parameters setObject:@"118" forKey:@"OPT"];
        [parameters setObject:@"" forKey:@"body"];
        [parameters setObject:_userId forKey:@"userId"];
        [parameters setObject:_phoneNumberTf.text forKey:@"mobile"];
        [parameters setObject:_verifyInput.text forKey:@"verifyCode"];
        [[NetWorkClient sharedInstance] requestGet:@"app/AppController" withParameters:parameters];
    }else{
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
        [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
        [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:71/255.0 green:71/255.0 blue:71/255.0 alpha:0.8888888]];
        [SVProgressHUD setMinimumDismissTimeInterval:3.0];
        [SVProgressHUD showImage:nil status:@"请重新获取验证码"];
    }
}


#pragma mark - NavBar 代理方法
- (void)leftItemClick{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)rightItemClick{
    
}



@end
