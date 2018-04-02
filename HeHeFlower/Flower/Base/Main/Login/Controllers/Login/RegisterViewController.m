//
//  RegisterViewController.m
//  JulijrP2P
//
//  Created by 韩 立 on 2016/12/25.
//  Copyright © 2016年 聚力金服网络科技有限公司. All rights reserved.
//
//  注册

#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "MyWebViewController.h"
#import "ReLogin.h"
#import "InputView.h"
#import <AddressBookUI/ABPeoplePickerNavigationController.h>
#import <AddressBook/ABPerson.h>
#import <AddressBookUI/ABPersonViewController.h>
#import <Contacts/Contacts.h>
#import <Contacts/ContactsDefines.h>
#import <ContactsUI/CNContactPickerViewController.h>
#import <ContactsUI/CNContactViewController.h>
#import <ContactsUI/ContactsUI.h>
#import "NetWorkClient.h"
#import "VersionUpdate.h"
#import "RegisterProctolViewController.h"
#import <WebKit/WebKit.h>
@interface RegisterViewController ()<WKUIDelegate,WKNavigationDelegate,HTTPClientDelegate, UITextFieldDelegate,NavBarDelegate,ABPeoplePickerNavigationControllerDelegate>
{
	BOOL _mbIsShowKeyboard;			//是否展示键盘
	UIButton *_verifyBtn;			//验证码按钮
	NSInteger _typeNum;				//请求类型
	UILabel  *_phoneLabel;			//手机号码提示label
	UIView   *_superView;			//主视图
	UIButton *_registBtn;			//注册按钮
	UIButton *_proctolBtn;			//会员注册协议按钮
	UIButton *_loginBtn;			//快速登录按钮
	UILabel  *_leftlabel;
    UILabel  *_leftlabel1;
	UILabel  *_rightlabel;
	NSString *_html;
//    SetGestureLockView *_setGestureView;
}

@property(nonatomic,strong) InputView *phoneInput;
@property(nonatomic,strong) InputView *pwdInput;
@property(nonatomic,strong) InputView *verifyInput;
@property(nonatomic,strong) InputView *inviteInput;
@property (nonatomic,strong) WKWebView *myWebView;
@end

@implementation RegisterViewController

#pragma mark - 控制器视图生命周期方法
-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
    [NetWorkClient sharedInstance].delegate = self;
	self.navigationController.navigationBarHidden = YES;
	[self ControlAction];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initView];
}

#pragma mark - 视图初始化
- (void)initView{
	self.navigationController.fd_prefersNavigationBarHidden = YES;
	self.view.backgroundColor = [UIColor whiteColor];
    
    [NetWorkClient sharedInstance].delegate = self;
    
    
    NavBar *navBar = [[NavBar alloc]initWithTitle:@"注册"];
    navBar.delegate = self;
    [self.view addSubview:navBar];
    
    _superView = [[UIView alloc]initWithFrame:MYTABLEVIEW_FRAME];
    _superView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:_superView];
    
    [self.view insertSubview:_superView belowSubview:navBar];
	
    //logo视图
    UIImageView *logoImgView = [UIImageView new];
    logoImgView.image = [UIImage imageNamed:@"带字logo"];
    [_superView addSubview:logoImgView];
    [logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_superView.mas_top).with.offset(20 * SCALE);
        make.centerX.mas_equalTo(_superView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(110* SCALE,45* SCALE));
    }];
	

	
	// 手机号输入栏
	_phoneInput = [[InputView alloc]initWithImgName:@"手机号" WithSelectImgName:@"regist_phone_normal" placeContent:@"填写本人手机号"];
	_phoneInput.inputField.delegate = self;
	[_phoneInput.inputField addTarget:self action:@selector(textFieldDidChange:)  forControlEvents:UIControlEventEditingChanged];
	[_superView addSubview:_phoneInput];
    [_phoneInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoImgView.mas_bottom).with.offset(55 * SCALE);
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
	_pwdInput = [[InputView alloc]initWithImgName:@"设置密码" WithSelectImgName:@"regist_pwd_normal" placeContent:@"输入登录密码"];
	_pwdInput.inputField.delegate = self;
	_pwdInput.inputField.secureTextEntry = YES;
	_pwdInput.inputField.clearButtonMode = UITextFieldViewModeNever;
	_pwdInput.inputField.keyboardType = UIKeyboardTypeDefault;
	[_pwdInput.inputField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
	[_superView addSubview:_pwdInput];
	[_pwdInput mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(_phoneLabel.mas_bottom).with.offset(13 * SCALE);
		make.left.equalTo(_superView.mas_left).with.offset(20);
		make.right.equalTo(_superView.mas_right).with.offset(-20);
		make.height.mas_equalTo(40 * SCALE);
	}];
	
	//眼睛按钮
	UIButton *eyeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[eyeBtn setBackgroundImage:[UIImage imageNamed:@"01"] forState:UIControlStateNormal];
	[eyeBtn setBackgroundImage:[UIImage imageNamed:@"02"] forState:UIControlStateSelected];
	eyeBtn.selected = NO;
	[eyeBtn addTarget:self action:@selector(eyeAction:) forControlEvents:UIControlEventTouchUpInside];
	[_superView addSubview:eyeBtn];
	[eyeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_phoneLabel.mas_bottom).with.offset(35 * SCALE);
		make.right.equalTo(_superView.mas_right).with.offset(-20);
		make.size.mas_equalTo(CGSizeMake(16.5 , 10));
	}];

	
	//获取验证码按钮
	_verifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _verifyBtn.layer.cornerRadius = 3.0;
    _verifyInput.layer.masksToBounds = YES;
	[_verifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_verifyBtn setBackgroundImage:[UIImage imageNamed:@"登录渐变"] forState:UIControlStateNormal];
//    [_verifyBtn setBackgroundImage:[UIImage imageNamed:@"登录渐变"] forState:UIControlStateDisabled];
	_verifyBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    _verifyBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
	[_verifyBtn addTarget:self action:@selector(VerifyBtnClick) forControlEvents:UIControlEventTouchUpInside];
	_verifyBtn.enabled = NO;
	[_superView addSubview:_verifyBtn];
	[_verifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_pwdInput.mas_bottom).with.offset(25 * SCALE);
		make.right.equalTo(_superView.mas_right).with.offset(-20);
		make.size.mas_equalTo(CGSizeMake(85 * SCALE, 25 * SCALE));
	}];
	
    
    //验证码输入栏
    _verifyInput = [[InputView alloc]initWithImgName:@"验证码" WithSelectImgName:@"regist_safe_normal" placeContent:@"6位数字验证码"];
    _verifyInput.inputField.delegate = self;
    [_verifyInput.inputField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_superView addSubview:_verifyInput];
    [_verifyInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_pwdInput.mas_bottom).with.offset(13 * SCALE);
        make.left.equalTo(_superView.mas_left).with.offset(20);
        make.right.equalTo(_verifyBtn.mas_left).with.offset(-15);
        make.height.mas_equalTo(40 * SCALE);
    }];
//
//    //邀请人手机号码输入栏
//    _inviteInput = [[InputView alloc]initWithImgName:@"regist_invite_normal" WithSelectImgName:@"regist_invite_normal" placeContent:@"邀请人手机号码"];
//    _inviteInput.inputField.delegate = self;
//    //[_superView addSubview:_inviteInput];
//    [_inviteInput mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_verifyInput.mas_bottom).with.offset(13 * SCALE);
//        make.left.equalTo(_superView.mas_left).with.offset(20);
//        make.right.equalTo(_superView.mas_right).with.offset(-20);
//        make.height.mas_equalTo(40 * SCALE);
//    }];
//
//    //通讯录按钮
//    UIButton  *adressBook = [[UIButton alloc] init];
//    [adressBook setBackgroundImage:[UIImage imageNamed:@"adressBook"] forState:UIControlStateNormal];
//    [adressBook addTarget:self action:@selector(adressBookAction:) forControlEvents:UIControlEventTouchUpInside];
//   // [_superView addSubview:adressBook];
//    [adressBook mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(_inviteInput.mas_centerY).with.offset(10);
//        make.right.equalTo(_superView.mas_right).with.offset(-20);
//        make.size.mas_equalTo(CGSizeMake(20 * SCALE, 20 * SCALE));
//    }];

    
    
	//注册按钮
	_registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[_registBtn setBackgroundImage:[UIImage imageNamed:@"登录渐变"] forState:UIControlStateNormal];
	[_registBtn setTitle:@"注册" forState:UIControlStateNormal];
	_registBtn.enabled = NO;
	_registBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
	[_registBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
	[_superView addSubview:_registBtn];
	[_registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(_verifyInput.mas_bottom).with.offset(25 * SCALE);
		make.left.equalTo(_superView.mas_left).with.offset(20);
		make.right.equalTo(_superView.mas_right).with.offset(-20);
		make.height.mas_equalTo(40 * SCALE);
	}];
    
    
    _leftlabel = [UILabel new];
    _leftlabel.text = @"注册即表示您已同意";
    _leftlabel.textColor = baseLightBlackColor;
    _leftlabel.font = [UIFont systemFontOfSize:12.0f];
    _leftlabel.adjustsFontSizeToFitWidth = YES;
    [_superView addSubview:_leftlabel];
    [_leftlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_registBtn.mas_bottom).with.offset(5 * SCALE);
        make.left.equalTo(_superView.mas_left).with.offset((MSWIDTH-233)/2);
        make.size.mas_equalTo(CGSizeMake(108, 25));
    }];

	
    //协议按钮
    UIButton *proctolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [proctolBtn setTitle:@"《互花使者服务协议》" forState:UIControlStateNormal];
    [proctolBtn setTitleColor:[ColorTools colorWithHexString:@"41b086"] forState:UIControlStateNormal];
//    [proctolBtn setBackgroundColor:[ColorTools colorWithHexString:@"41b086"]];
    proctolBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [proctolBtn addTarget:self action:@selector(proctolBtnAction) forControlEvents:UIControlEventTouchUpInside];
    _proctolBtn = proctolBtn;
    [_superView addSubview:proctolBtn];
    [proctolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_registBtn.mas_bottom).with.offset(5 * SCALE);
        make.left.equalTo(_leftlabel.mas_right).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(125, 25));
    }];
    
    _leftlabel1 = [UILabel new];
    _leftlabel1.text = @"已有账号？";
    _leftlabel1.textColor = [ColorTools colorWithHexString:@"41b086"];
    _leftlabel1.font = [UIFont systemFontOfSize:12.0f];
    _leftlabel1.adjustsFontSizeToFitWidth = YES;
    [_superView addSubview:_leftlabel1];
    [_leftlabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(proctolBtn.mas_bottom).with.offset(15 * SCALE);
        make.left.equalTo(_superView.mas_left).with.offset((MSWIDTH-110)/2);
        make.size.mas_equalTo(CGSizeMake(60, 25));
    }];
    
  
	//登录按钮
	UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[loginBtn setTitle:@"马上登录" forState:UIControlStateNormal];
	[loginBtn setTitleColor:[ColorTools colorWithHexString:@"41b086"] forState:UIControlStateNormal];
	[loginBtn setBackgroundColor:[UIColor clearColor]];
	loginBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
	[loginBtn addTarget:self action:@selector(backItemClick) forControlEvents:UIControlEventTouchUpInside];
	_loginBtn =loginBtn;
	[_superView addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(proctolBtn.mas_bottom).with.offset(15 * SCALE);
        make.left.equalTo(_leftlabel1.mas_right).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(50, 25));
    }];
	

	
}


#pragma mark - 点击空白处收回键盘
- (void)ControlAction{
	[self.view endEditing:YES];
	[self hidePhoneLabel];
}


#pragma mark - 按钮事件触发
/* 获取验证码按钮事件触发 */
- (void)VerifyBtnClick{
	if ([_phoneInput.inputField.text isPhone]) {
		DLOG(@"PhoneNum is right");

		[self getVerification];
	}
	else {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
        [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
        [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:71/255.0 green:71/255.0 blue:71/255.0 alpha:0.8888888]];
        [SVProgressHUD setMinimumDismissTimeInterval:3.0];
		[SVProgressHUD showImage:nil status:@"手机号码格式不正确"];
	}
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
                [_verifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                _verifyBtn.enabled = YES;
                [_verifyBtn setAlpha:1];
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [_verifyBtn setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                _verifyBtn.enabled = NO;
                [_verifyBtn setAlpha:0.4];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}


/* 注册按钮事件触发 */
- (void)registerAction{
	_typeNum = 0;
	[self ControlAction];
	[[AppDefaultUtil sharedInstance] setPhoneNum:_phoneInput.inputField.text];// 保存用户账号(手机号)
	NSString *pwdStr = [NSString encrypt3DES:_pwdInput.inputField.text key:DESkey];//用户密码3Des加密
	NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
	[parameters setObject:@"113" forKey:@"OPT"];
	[parameters setObject:@"" forKey:@"body"];
	[parameters setObject:_phoneInput.inputField.text forKey:@"mobile"];
	[parameters setObject:pwdStr forKey:@"password"];
	[parameters setObject:_verifyInput.inputField.text forKey:@"verificationCode"];
	[[NetWorkClient sharedInstance] requestGet:@"app/AppController" withParameters:parameters];
}

/* 平台注册协议按钮事件触发 */
- (void)proctolBtnAction{
    RegisterProctolViewController *proctolVC = [[RegisterProctolViewController alloc]init];
    [self.navigationController pushViewController:proctolVC animated:NO];
}


#pragma mark - 网络数据请求
/* 获取验证码网络请求 */
-(void) getVerification{
	_typeNum = 1;
	NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
	[parameters setObject:@"111" forKey:@"OPT"];
	[parameters setObject:@"" forKey:@"body"];
	[parameters setObject:_phoneInput.inputField.text forKey:@"mobile"];
	[parameters setObject:@"REGISTER" forKey:@"scene"];
	[[NetWorkClient sharedInstance] requestGet:@"app/AppController" withParameters:parameters];
}


#pragma mark - 网络数据回调代理方法
//开始请求
-(void) startRequest{
	[DejalActivityView activityViewForView:self.view];
}

// 返回成功
-(void) httpResponseSuccess:(NetWorkClient *)client dataTask:(NSURLSessionDataTask *)task didSuccessWithObject:(id)obj{
	NSDictionary *dics = obj;
	DLOG(@"返回的参数如下:%@",dics);
	if ([[NSString stringWithFormat:@"%@",[dics objectForKey:@"code"]] isEqualToString:@"1"]) {
		if (_typeNum == 0) {
            
            
            NSString *userId = [NSString stringWithFormat:@"%@",[obj objectForKey:@"userId"]];
            DLOG(@"userSignId --> %@",userId);
            //保存用户注册成功后得到的用户ID
            [[AppDefaultUtil sharedInstance] setDefaultUserID:userId];//保存用户名
            [[AppDefaultUtil sharedInstance] setPhoneNum:_phoneInput.inputField.text];//保存手机号
            NSString *pwdStr = [NSString encrypt3DES:_pwdInput.inputField.text key:DESkey];//用户密码3Des加密
            // 保存用户加密后的密码
            [[AppDefaultUtil sharedInstance] setPassword:pwdStr];
            //记录登录状态
            [[AppDefaultUtil sharedInstance] setLoginState:YES];
            
            //记住第一次从注册到登陆的状态
            [[AppDefaultUtil sharedInstance] setFromRegisterToLoginState:YES];
            
            self.backType = ChangeRootView;
            
//            _setGestureView = [[SetGestureLockView alloc]initWithFrame:[[UIScreen mainScreen] bounds] delegate:self];
//            [_setGestureView show];
            
		}else if (_typeNum == 1) {
			// 是否成功发送验证码
			DLOG(@"msg  -> %@", [obj objectForKey:@"msg"]);
            [self countdown];
		}
		else if (_typeNum == 2){
			_html = [NSString stringWithFormat:@"%@", [obj objectForKey:@"html"]];
			DLOG(@"html --> %@",_html);
			NSString	*htmlTitle = [NSString stringWithFormat:@"%@",[obj objectForKey:@"htmlTitle"]];
            DLOG(@"htmlTitle --> %@",htmlTitle);
            MyWebViewController *myWebVc = [[MyWebViewController alloc] init];
            myWebVc.html = _html;
            myWebVc.title = @"平台注册协议";
            [self.navigationController pushViewController:myWebVc animated:YES];
            
		}
		else{
			// 登录成功
			DLOG(@"msg -> %@",[obj objectForKey:@"msg"]);
			DLOG(@"error -> %@",[obj objectForKey:@"error"]);
			//			[self loginSuccess];
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

#pragma mark - textfield代理方法
/* 动态视图方法 */
- (void) textFieldDidBeginEditing:(UITextField *)textField
{
	if (_phoneInput.inputField == textField ) {
		_phoneInput.leftImg.highlighted = YES;
		[self  hidePhoneLabel];
		[self  moveView];
	}
	else if (_pwdInput.inputField == textField){
		_pwdInput.leftImg.highlighted = YES;
		[self  moveView];
	}
	else if (_verifyInput.inputField == textField){
		_verifyInput.leftImg.highlighted = YES;
		[self  moveView];
	}
	else if (_inviteInput.inputField == textField){
		_inviteInput.leftImg.highlighted = YES;
		[self  moveView];
	}
}

/* 动态视图方法 */
- ( void )textFieldDidEndEditing:( UITextField *)textField{
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
		[self resumeView];
	}
	else if (_verifyInput.inputField == textField){
		_verifyInput.leftImg.highlighted = NO;
		[self resumeView];
	}
	else if (_inviteInput.inputField == textField){
		_inviteInput.leftImg.highlighted = NO;
		[self resumeView];
	}
}


/* 限制各个输入框的输入长度 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
	if (_phoneInput.inputField == textField) {
		if (range.location>= 11){
			return NO;
		}
	}
	else if (_pwdInput.inputField == textField){
		if (range.location>= 15) {
			return NO;
		}
	}
	else if (_verifyInput.inputField == textField){
		if (range.location >= 6) {
			return NO;
		}
	}
	return YES;
}

// 实时监测textfield里面内容变化
-(void)textFieldDidChange:(id)sender{
	UITextField *textField = (UITextField *)sender;
	if (_phoneInput.inputField == textField) {
		_verifyBtn.enabled = NO;
		if ([_phoneInput.inputField.text isPhone]) {
			_verifyBtn.enabled = YES;
		}
	}
	if (_verifyInput.inputField.text.length == 6 && [_phoneInput.inputField.text isPhone] && _pwdInput.inputField.text.length > 5) {
            [_registBtn setBackgroundImage:[UIImage imageNamed:@"登录渐变"] forState:UIControlStateNormal];
		_registBtn.enabled = YES;
    }else{
                [_registBtn setBackgroundImage:[UIImage imageNamed:@"登录渐变"] forState:UIControlStateNormal];
        _registBtn.enabled = NO;
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:@"UITextFieldTextDidChangeNotification"
                                                 object:_phoneInput];
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:@"UITextFieldTextDidChangeNotification"
                                                 object:_pwdInput];
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:@"UITextFieldTextDidChangeNotification"
                                                 object:_verifyInput];
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:@"UITextFieldTextDidChangeNotification"
                                                 object:_inviteInput];
}
#pragma mark - 视图动态移动方法
//  视图上移
-(void) moveView{
	if ( !_mbIsShowKeyboard ){
		NSTimeInterval animationDuration=0.30f;
		[UIView beginAnimations:@"ResizeForKeyboard" context:nil];
		[UIView setAnimationDuration:animationDuration];
	
        CGRect superRect = _superView.frame;
        superRect.origin.y = _superView.frame.origin.y - 90 * SCALE;
        _superView.frame = superRect;
        
		[UIView commitAnimations];
		_mbIsShowKeyboard = true;
	}
	
}


//  视图恢复
-(void)resumeView{
	if ( _mbIsShowKeyboard )
	{
		NSTimeInterval animationDuration=0.30f;
		[UIView beginAnimations:@"ResizeForKeyboard" context:nil];
		[UIView setAnimationDuration:animationDuration];
		
		//如果当前View是父视图，则Y为20个像素高度，如果当前View为其他View的子视图，则动态调节Y的高度
        CGRect superRect = _superView.frame;
        superRect.origin.y = _superView.frame.origin.y + 90 * SCALE;
        _superView.frame = superRect;
		[UIView commitAnimations];
		_mbIsShowKeyboard = false;
	}
}


// 展示号码错误提示label
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

/* 隐藏手机提示label */
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

// 眼睛按钮事件触发
- (void)eyeAction:(UIButton *)sender{
	[_pwdInput.inputField becomeFirstResponder];
	sender.selected = !sender.selected;
	if (sender.selected) {
		_pwdInput.inputField.secureTextEntry = NO;
	}
	else if (!sender.selected){
		_pwdInput.inputField.secureTextEntry = YES;
	}
}

//通讯录按钮事件
- (void)adressBookAction:(UIButton *)sender{
    ABPeoplePickerNavigationController *nav = [[ABPeoplePickerNavigationController alloc] init];
    nav.peoplePickerDelegate = self;
    nav.predicateForSelectionOfPerson = [NSPredicate predicateWithValue:false];
    [self presentViewController:nav animated:YES completion:nil];
}

//取消选择
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
}
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
    long index = ABMultiValueGetIndexForIdentifier(phone,identifier);
    NSString *phoneNO = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phone, index);
    
    if ([phoneNO hasPrefix:@"+"]) {
        phoneNO = [phoneNO substringFromIndex:3];
    }
    
    phoneNO = [phoneNO stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSLog(@"%@", phoneNO);
    if (phone) {
        _inviteInput.inputField.text = phoneNO;
        [peoplePicker dismissViewControllerAnimated:YES completion:nil];
        return;
    }
}

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person
{
    ABPersonViewController *personViewController = [[ABPersonViewController alloc] init];
    personViewController.displayedPerson = person;
    [peoplePicker pushViewController:personViewController animated:YES];
}

#pragma mark - 设置手势成功
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
        
        [self.navigationController popViewControllerAnimated:NO];
   //     [_setGestureView removeFromSuperview];
        //检测版本更新
        [[VersionUpdate sharedInstance]checkUpdateWithDelegate:nil];
    }
}


#pragma mark - NavBar 代理方法
- (void)backItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)leftItemClick{
    
    
}

- (void)rightItemClick
{
    DLOG(@"下一步");
}

-(void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
	self.navigationController.navigationBarHidden = NO;
}


@end
