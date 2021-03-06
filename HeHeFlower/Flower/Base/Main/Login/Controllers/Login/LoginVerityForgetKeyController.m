//
//  LoginVerityForgetKeyController.m
//  JulijrP2P
//
//  Created by 韩 立 on 2017/2/24.
//  Copyright © 2017年 聚力金服网络科技有限公司. All rights reserved.
//

#import "LoginVerityForgetKeyController.h"

#import "EditView.h"
#import "InputView.h"
#import "NetWorkClient.h"

@interface LoginVerityForgetKeyController ()<UITextFieldDelegate,NavBarDelegate,HTTPClientDelegate>
{
    NSMutableString *phoneNum;
    NSInteger _typeNum;				//请求类型
}
@property (nonatomic,strong)EditView *changeKeyTf;
@property (nonatomic,strong)EditView *reChangeKeyTf;
@property (nonatomic,strong)UILabel *rePhoneTitleLabel;
@property (nonatomic,strong)UILabel *rePhoneNumLabel;
@property (nonatomic,strong)UILabel *writePhoneTitleLabel;
@property (nonatomic,strong)UIButton *doneBtn;
@property (nonatomic, strong)UIButton *getVerifyNum;
@end

@implementation LoginVerityForgetKeyController

#pragma mark - 控制器视图生命周期
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [UIApplication sharedApplication].statusBarHidden = NO;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self initView];
}

#pragma mark - 视图初始化
- (void)initView
{
    NavBar *navBar = [[NavBar alloc]initWithTitle:@"新密码"];
    navBar.delegate = self;
    [self.view addSubview:navBar];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [NetWorkClient sharedInstance].delegate = self;

    
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, MSWIDTH, 20)];
    backImage.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1];
    [self.view addSubview:backImage];
    
    _changeKeyTf = [[EditView alloc]initWithTitle:@"新密码" WithPlaceContent:@"请输入新密码"];
    _changeKeyTf.frame = CGRectMake(0, NAVBAR_HEIGHT +30, MSWIDTH, ITHIGHT);
    //	_changeKeyTf.inputField.delegate = self;
    [self.view addSubview:_changeKeyTf];
    
    _reChangeKeyTf = [[EditView alloc]initWithTitle:@"新密码确认" WithPlaceContent:@"请再次输入新密码"];
    _reChangeKeyTf.frame = CGRectMake(0, ITHIGHT +NAVBAR_HEIGHT +30, MSWIDTH, ITHIGHT);
    [self.view addSubview:_reChangeKeyTf];
    
    UIImageView *backImage_2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, ITHIGHT * 3 +NAVBAR_HEIGHT +30, MSWIDTH, 20)];
    backImage_2.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1];
    [self.view addSubview:backImage_2];
    
    _doneBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, ITHIGHT * 3 +NAVBAR_HEIGHT +60, MSWIDTH-20, 55)];
    [_doneBtn setTitle:@"提交新密码" forState:UIControlStateNormal];
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
                                                 object:_changeKeyTf];
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:@"UITextFieldTextDidChangeNotification"
                                                 object:_reChangeKeyTf];
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
            //找回密码成功，直接跳转首页
            [[AppDefaultUtil sharedInstance]setLoginState:NO];
            TabBarController *tabbarVC = [[TabBarController alloc] init];
            [tabbarVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
            [self presentViewController:tabbarVC animated:YES completion:nil];
    }else{
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
        [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
        [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:71/255.0 green:71/255.0 blue:71/255.0 alpha:0.8888888]];
        [SVProgressHUD setMinimumDismissTimeInterval:3.0];
        [SVProgressHUD showImage:nil status:[NSString stringWithFormat:@"%@", [obj objectForKey:@"msg"]]];
    }
}



#pragma mark - 确认按钮事件
- (void)doneReSet{
    if (![_changeKeyTf.inputField.text isEqualToString:_reChangeKeyTf.inputField.text]) {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
        [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
        [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:71/255.0 green:71/255.0 blue:71/255.0 alpha:0.8888888]];
        [SVProgressHUD setMinimumDismissTimeInterval:3.0];
        [SVProgressHUD showImage:nil status:@"新密码输入不一致"];
        return;
    }
    
    if (_changeKeyTf.inputField.text.length < 6 || _changeKeyTf.inputField.text.length > 16){
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
        [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
        [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:71/255.0 green:71/255.0 blue:71/255.0 alpha:0.8888888]];
        [SVProgressHUD setMinimumDismissTimeInterval:3.0];
        [SVProgressHUD showImage:nil status:@"密码长度为6-16位"];
        return;
    }
    DLOG(@"用户id 为:%@",_userId);
    DLOG(@"%@", _verifyCodeInHere);
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:@"263" forKey:@"OPT"];
    [parameters setObject:@"" forKey:@"body"];
    [parameters setObject:[NSString stringWithFormat:@"%@",_userId] forKey:@"userId"]; //用户id
    [parameters setObject:_verifyCodeInHere forKey:@"verifyCode"];
    NSString *newPwdStr = [NSString encrypt3DES:_changeKeyTf.inputField.text key:DESkey];
    NSString *reNewPwdStr = [NSString encrypt3DES:_reChangeKeyTf.inputField.text key:DESkey];
    [parameters setObject:newPwdStr forKey:@"password"];
    [parameters setObject:reNewPwdStr forKey:@"passwordAgain"];
    [parameters setObject:@"FORGOT_LOGINPWD" forKey:@"secne"];
    [[NetWorkClient sharedInstance] requestGet:@"app/AppController" withParameters:parameters];
}


#pragma mark - NavBar 代理方法
- (void)leftItemClick{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)rightItemClick{
    
}

@end
