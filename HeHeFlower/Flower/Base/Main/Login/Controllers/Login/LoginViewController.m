//
//  LoginViewController.m
//  JulijrP2P
//
//  Created by 韩 立 on 2016/12/25.
//  Copyright © 2016年 聚力金服网络科技有限公司. All rights reserved.
//
//  登录

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForgetKeyController.h"
#import "InputView.h"

#import "NetWorkClient.h"
#import "VersionUpdate.h"

@interface LoginViewController ()<HTTPClientDelegate, UITextFieldDelegate,NavBarDelegate>
{
	UIButton *_loginBtn;			//登录按钮
	BOOL _isLoading;				//是否为登录状态
	NSInteger _typeNum;
	BOOL _mbIsShowKeyboard;			//是否显示键盘
	BOOL _phoneLabelSpread;			//手机号码提示框是否展开
	UILabel *_phoneLabel;			//手机号码错误提示label
	UIView *_superView;
	UIView *_cover;

}
@property(nonatomic ,strong) InputView *phoneInput;
@property(nonatomic ,strong) InputView *pwdInput;

@end

@implementation LoginViewController

#pragma mark - 控制器视图生命周期方法
-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
    [NetWorkClient sharedInstance].delegate = self;
	self.navigationController.navigationBarHidden = YES;
	[self ControlAction];
}


- (void)viewDidLoad{
	[super viewDidLoad];

	[self initView];
}


- (void)initView{
	self.navigationController.navigationBar.translucent = NO;
	self.view.backgroundColor = [UIColor whiteColor];
    
    [NetWorkClient sharedInstance].delegate = self;
//    AppDelegateInstance.nav = 5;
    NavBar *navBar = [[NavBar alloc]initWithTitle:@"账户登录"];
    navBar.delegate = self;
    [self.view addSubview:navBar];
    

    _superView = [[UIView alloc]initWithFrame:MYTABLEVIEW_FRAME];
    _superView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_superView];
    
    [self.view insertSubview:_superView belowSubview:navBar];
    
	//logo视图
	UIImageView *logoImgView = [UIImageView new];
	logoImgView.image = [UIImage imageNamed:@"带字logo"];
	[_superView addSubview:logoImgView];
	[logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(_superView.mas_top).with.offset(30 * SCALE);
		make.centerX.mas_equalTo(_superView.mas_centerX);
		make.size.mas_equalTo(CGSizeMake(110*SCALE,45*SCALE));
	}];
	
	
	//手机号输入栏
	_phoneInput = [[InputView alloc]initWithImgName:@"账号" WithSelectImgName:@"regist_phone_normal" placeContent:@"输入手机号"];
	_phoneInput.inputField.delegate = self;
	[_superView addSubview:_phoneInput];
	[_phoneInput mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(logoImgView.mas_bottom).with.offset(40 * SCALE);
		make.left.equalTo(_superView.mas_left).with.offset(20);
		make.right.equalTo(_superView.mas_right).with.offset(-20);
		make.height.mas_equalTo(40 * SCALE);
	}];

	//号码错误提示label
	_phoneLabel = [UILabel new];
	_phoneLabel.backgroundColor = [UIColor clearColor];
	_phoneLabel.textAlignment = NSTextAlignmentCenter;
	[_superView addSubview:_phoneLabel];
	[_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(_phoneInput.mas_bottom).with.offset(0.5);
		make.left.equalTo(_superView.mas_left).with.offset(40);
		make.right.equalTo(_superView.mas_right).with.offset(-20);
		make.height.mas_equalTo(1);
	}];
	
	//密码输入栏
	_pwdInput = [[InputView alloc]initWithImgName:@"密码" WithSelectImgName:@"regist_pwd_normal" placeContent:@"输入登录密码"];
	_pwdInput.inputField.delegate = self;
	_pwdInput.inputField.secureTextEntry = YES;
	_pwdInput.inputField.keyboardType = UIKeyboardTypeDefault;
	[_pwdInput.inputField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
	[_superView addSubview:_pwdInput];
	[_pwdInput mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(_phoneLabel.mas_bottom).with.offset(13 * SCALE);
		make.left.equalTo(_superView.mas_left).with.offset(20);
		make.right.equalTo(_superView.mas_right).with.offset(-20);
		make.height.mas_equalTo(40 * SCALE);
	}];

	//登录按钮
	_loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[_loginBtn setBackgroundImage:[UIImage imageNamed:@"登录渐变"] forState:UIControlStateNormal];
	[_loginBtn addTarget:self action:@selector(loginBtnAction) forControlEvents:UIControlEventTouchUpInside];
	[_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
	_loginBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
	_loginBtn.enabled = NO;
	[_superView addSubview:_loginBtn];
	[_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(_pwdInput.mas_bottom).with.offset(26 * SCALE);
		make.left.equalTo(_superView.mas_left).with.offset(20);
		make.right.equalTo(_superView.mas_right).with.offset(-20);
		make.height.mas_equalTo(40 * SCALE);
    }];
	
    
    //忘记密码按钮
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:[ColorTools colorWithHexString:@"#41b086"] forState:UIControlStateNormal];

    [forgetBtn setBackgroundColor:[UIColor clearColor]];
    forgetBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [forgetBtn addTarget:self action:@selector(forgetBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_superView addSubview:forgetBtn];
    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_loginBtn.mas_bottom).with.offset(15 * SCALE);
        make.right.equalTo(_superView.mas_right).with.offset(-15);
       	make.size.mas_equalTo(CGSizeMake(70*SCALE, 25*SCALE));
    }];
    
	//注册按钮
	UIButton *registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[registBtn setTitle:@"免费注册" forState:UIControlStateNormal];
	[registBtn setTitleColor:[ColorTools colorWithHexString:@"#41b086"] forState:UIControlStateNormal];
	[registBtn setBackgroundColor:[UIColor clearColor]];
	registBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
	[registBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
	[_superView addSubview:registBtn];
	[registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_superView.mas_left).with.offset(15);
        make.top.equalTo(_loginBtn.mas_bottom).with.offset(15 * SCALE);
		make.size.mas_equalTo(CGSizeMake(70*SCALE, 25*SCALE));
	}];
	


}


#pragma mark - 按钮事件触发
/*注册按钮触发*/
-(void)registBtnClick{
	[self resumeView];
	[self ControlAction];
	RegisterViewController *registView = [[RegisterViewController alloc] init];
	[self.navigationController pushViewController:registView animated:YES];
}

/*忘记密码按钮触发*/
-(void)forgetBtnAction{
	[self ControlAction];
	ForgetKeyController *forVC = [[ForgetKeyController alloc] init];
	UINavigationController *navVc = [[UINavigationController alloc]initWithRootViewController:forVC];
	[self presentViewController:navVc animated:YES completion:nil];
}

/*登录按钮触发*/
-(void)loginBtnAction{
    [self ControlAction];
    _typeNum = 1;
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString *password1 = [NSString encrypt3DES:_pwdInput.inputField.text key:DESkey];
    [parameters setObject:@"3" forKey:@"OPT"];
    [parameters setObject:_phoneInput.inputField.text forKey:@"jobnumber"];
    [parameters setObject:password1 forKey:@"password"];
    [[NetWorkClient sharedInstance] requestGet:@"appController/receive" withParameters:parameters];
}


#pragma mark - 网络数据回调代理
// 开始请求
-(void) startRequest{
	[DejalActivityView activityViewForView:self.view];
	_isLoading = YES;
}

// 返回成功
-(void) httpResponseSuccess:(NetWorkClient *)client dataTask:(NSURLSessionDataTask *)task didSuccessWithObject:(id)obj{
    NSDictionary *dics = obj;
    DLOG(@"返回的参数如下:%@",dics);
    if ([[NSString stringWithFormat:@"%@",[dics objectForKey:@"code"]] isEqualToString:@"1"]) {
        if(_typeNum == 1){
            DLOG(@"返回成功:登录信息-> %@",[obj objectForKey:@"msg"]);
            
            NSString *userId = [NSString stringWithFormat:@"%@",[obj objectForKey:@"t_id"]];
            DLOG(@"userSignId --> %@",userId);
            //保存用户注册成功后得到的用户ID
            [[AppDefaultUtil sharedInstance] setDefaultUserID:userId];
            
            // 登录成功，记住密码,记录登录状态. 保存账号密码到UserDefault
            [[AppDefaultUtil sharedInstance] setDefaultUserName:_phoneInput.inputField.text];//保存用户名
            NSString *pwdStr = [NSString encrypt3DES:_pwdInput.inputField.text key:DESkey];//用户密码3Des加密
            [[AppDefaultUtil sharedInstance] setPassword:pwdStr];// 保存用户密码（des加密）
            [[AppDefaultUtil sharedInstance] setLoginState:YES];
           // [self dismissViewControllerAnimated:YES completion:nil];
           // [self.tabBarController setSelectedIndex:0];
            TabBarController *tabbarVC = [[TabBarController alloc] init];
            [self presentViewController:tabbarVC animated:NO completion:^{
                
            }];
        }
    }
    else if ([[NSString stringWithFormat:@"%@",[dics objectForKey:@"code"]] isEqualToString:@"-1"]){
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
        [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
        [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:71/255.0 green:71/255.0 blue:71/255.0 alpha:0.8888888]];
        [SVProgressHUD setMinimumDismissTimeInterval:2.0];
        [SVProgressHUD setErrorImage:nil];
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[dics objectForKey:@"msg"]]];
    }
    else{
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
        [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
        [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:71/255.0 green:71/255.0 blue:71/255.0 alpha:0.8888888]];
        [SVProgressHUD setMinimumDismissTimeInterval:2.0];
        [SVProgressHUD showImage:nil status:[NSString stringWithFormat:@"%@", [dics  objectForKey:@"msg"]]];
    }
}


// 返回失败
-(void) httpResponseFailure:(NetWorkClient *)client dataTask:(NSURLSessionDataTask *)task didFailWithError:(NSError *)error
{
	_isLoading  = NO;
}


// 无可用的网络
-(void) networkError
{
	_isLoading  = NO;
}



#pragma mark - 点击空白处收回键盘
- (void)ControlAction{
	[self.view endEditing:YES];
}


#pragma mark - textfield代理方法
//开始进入编辑状态
- (void) textFieldDidBeginEditing:(UITextField *)textField{
	
	if (_phoneInput.inputField == textField ) {
		_phoneInput.leftImg.highlighted = YES;
		[self hidePhoneLabel];
		[self moveView];
	}
	
	else if (_pwdInput.inputField == textField){
		_pwdInput.leftImg.highlighted = YES;
		[self moveView];
	}
}

//结束编辑
- (void)textFieldDidEndEditing:(UITextField *)textField{
	if (_phoneInput.inputField == textField ) {
		_phoneInput.leftImg.highlighted = NO;
		
		if (_phoneInput.inputField.text.length) {
			if (![_phoneInput.inputField.text isPhone]) {
				[self showPhoneLabel];
			}
		}
		[self  resumeView];
	}
	else if (_pwdInput.inputField == textField){
		_pwdInput.leftImg.highlighted = NO;
		[self  resumeView];
	}
}

//限制输入框输入长度
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
	if (_phoneInput.inputField == textField) {
		if (range.location>= 11  && ![string isEqualToString:@""]){
			return NO;
		}
	}
	else if (_pwdInput.inputField == textField){
		if (range.location>= 16  && ![string isEqualToString:@""]) {
			return NO;
		}
	}
	return YES;
}

// 监听密码输入框的输入（正在编辑中）
-(void)textFieldDidChange:(id)sender{
	UITextField *textField = (UITextField *)sender;
	_loginBtn.enabled = NO;
	if (textField.text.length > 5) {
         [_loginBtn setBackgroundImage:[UIImage imageNamed:@"登录渐变"] forState:UIControlStateNormal];
//        [_loginBtn setTitleColor:[UIColor colorWithRed:0.1 green:0.1 blue:0. alpha:0.1] forState:UIControlStateNormal];
		_loginBtn.enabled = YES;
    }else{
              [_loginBtn setBackgroundImage:[UIImage imageNamed:@"登录渐变"]
                                   forState:UIControlStateNormal];
//        [_loginBtn setTitleColor:[UIColor colorWithRed:0.1 green:0.1 blue:0. alpha:0.1] forState:UIControlStateNormal];
        _loginBtn.enabled = NO;
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:@"UITextFieldTextDidChangeNotification"
                                                 object:_phoneInput];
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:@"UITextFieldTextDidChangeNotification"
                                                 object:_pwdInput];
}


#pragma mark - 动态视图方法
// 视图上移
-(void) moveView{
	
	if ( !_mbIsShowKeyboard ){
		
		NSTimeInterval animationDuration=0.30f;
		[UIView beginAnimations:@"ResizeForKeyboard" context:nil];
		[UIView setAnimationDuration:animationDuration];

        CGRect superRect = _superView.frame;
        superRect.origin.y = _superView.frame.origin.y - 25 * SCALE;
		_superView.frame = superRect;
        
		[UIView commitAnimations];
		
		//[self performSelector:@selector(showforgetBtn) withObject:nil afterDelay:1.0f];
		_mbIsShowKeyboard = true;
	}
}


// 视图恢复
-(void)resumeView{
	if ( _mbIsShowKeyboard ){
		NSTimeInterval animationDuration=0.30f;
		[UIView beginAnimations:@"ResizeForKeyboard" context:nil];
		[UIView setAnimationDuration:animationDuration];
		
		//如果当前View是父视图，则Y为20个像素高度，如果当前View为其他View的子视图，则动态调节Y的高度
        CGRect superRect = _superView.frame;
        superRect.origin.y = _superView.frame.origin.y + 25 * SCALE;
        _superView.frame = superRect;
        
		[UIView commitAnimations];
		_mbIsShowKeyboard = false;
	}
}

//   展示号码错误提示label
- (void)showPhoneLabel{
	NSTimeInterval animationDuration=0.30f;
	[UIView beginAnimations:@"ShowPhoneLabel" context:nil];
	[UIView setAnimationDuration:animationDuration];
	_phoneLabel.backgroundColor = [UIColor clearColor];
	_phoneLabel.text = @"请输入正确的手机号码";
	_phoneLabel.font = [UIFont systemFontOfSize:13.0f];
	_phoneLabel.textColor = baseNavColor;
	_phoneLabel.textAlignment = NSTextAlignmentLeft;
	[_phoneLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(_phoneInput.mas_bottom).with.offset(0.5);
		make.left.equalTo(_superView.mas_left).with.offset(40);
		make.right.equalTo(_superView.mas_right).with.offset(-20);
		make.height.mas_equalTo(30);
	}];
	[UIView commitAnimations];
}

//  隐藏号码错误提示label
- (void)hidePhoneLabel{
	NSTimeInterval animationDuration=0.30f;
	[UIView beginAnimations:@"ShowPhoneLabel" context:nil];
	[UIView setAnimationDuration:animationDuration];
	_phoneLabel.backgroundColor = [UIColor clearColor];
	_phoneLabel.text = nil;
	_phoneLabel.font = [UIFont systemFontOfSize:13.0f];
	_phoneLabel.textColor = [UIColor orangeColor];
	_phoneLabel.textAlignment = NSTextAlignmentCenter;
	[_phoneLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(_phoneInput.mas_bottom).with.offset(0.5);
		make.left.equalTo(_superView.mas_left).with.offset(40);
		make.right.equalTo(_superView.mas_right).with.offset(-20);
		make.height.mas_equalTo(1);
	}];
	[UIView commitAnimations];
}
#pragma mark - 登录成功保存登录状态
-(void) loginSuccess{
    
    // 登录成功，记住密码,记录登录状态. 保存账号密码到UserDefault
    [[AppDefaultUtil sharedInstance] setPhoneNum:_phoneInput.inputField.text];//保存手机号
    NSString *pwdStr = [NSString encrypt3DES:_pwdInput.inputField.text key:DESkey];//用户密码3Des加密
    [[AppDefaultUtil sharedInstance] setPassword:pwdStr];// 保存用户密码（des加密）
    [[AppDefaultUtil sharedInstance] setLoginState:YES];
//    NSString *a = @"on";
//    [[NSUserDefaults standardUserDefaults] setObject:a forKey:@"on"];
//    _setGestureView = [[SetGestureLockView alloc]initWithFrame:[[UIScreen mainScreen] bounds] delegate:self];
//    [_setGestureView show];
    TabBarController *tabbarVC = [[TabBarController alloc] init];
    [self presentViewController:tabbarVC animated:NO completion:^{
     
    }];
//    [self.navigationController pushViewController:tabbarVC animated:NO];
    //检测版本更新
    [[VersionUpdate sharedInstance]checkUpdateWithDelegate:nil];
    
}


#pragma mark - SetGestureLockViewDelegate
- (void)setGestureLockSuccess
{
    if (self.backType == ChangeRootView)
    {
        //直接跳转首页
        TabBarController *tabbarVC = [[TabBarController alloc] init];
        [self presentViewController:tabbarVC animated:NO completion:^{
//            [_setGestureView removeFromSuperview];
        }];
        //检测版本更新
        [[VersionUpdate sharedInstance]checkUpdateWithDelegate:nil];
        
        
    }else{
        if (self.backType == MinePage)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:CHANGETABBAR object:@"3"];
        }
        
        [self dismissViewControllerAnimated:NO completion:^{
//             [_setGestureView removeFromSuperview];
        }];
        //检测版本更新
        [[VersionUpdate sharedInstance]checkUpdateWithDelegate:nil];
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
	return NO;
}


-(void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
	if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
		self.navigationController.interactivePopGestureRecognizer.delegate = nil;
	}
	[self.navigationItem setHidesBackButton:YES];
}

#pragma mark - NavBar 代理方法
- (void)leftItemClick
{
//    if (self.backType == ChangeRootView || self.backType == LoginTimeOut)
//    {
//        //直接跳转首页
//        [[AppDefaultUtil sharedInstance]setLoginState:NO];
//        TabBarController *tabbarVC = [[TabBarController alloc] init];
//        [tabbarVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
//        [self presentViewController:tabbarVC animated:YES completion:nil];
//    }
//    else
//    {
//        if (self.tabBarController.selectedIndex == 3)
//        {
//            [[NSNotificationCenter defaultCenter] postNotificationName:CHANGETABBAR object:@"0"];
//        }
//        [[AppDefaultUtil sharedInstance]setLoginState:NO];
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }
}

- (void)rightItemClick
{
    DLOG(@"下一步");
}

@end
