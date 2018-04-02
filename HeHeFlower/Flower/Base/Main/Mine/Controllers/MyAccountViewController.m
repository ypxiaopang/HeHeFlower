//
//  MyAccountViewController.m
//  JulijrP2P
//
//  Created by 韩 立 on 2017/1/16.
//  Copyright © 2017年 聚力金服网络科技有限公司. All rights reserved.


#import "MyAccountViewController.h"
#import "LoginViewController.h"
#import "MyNavigationController.h"
#import "AppDelegate.h"
#import "MyAccountCell.h"
#import "SetViewController.h"
#import "AssoicateViewController.h"
#import "HistoryPlantsViewController.h"
#import "CommonQuestionViewController.h"
@interface MyAccountViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, retain)UIImageView *viewOfAccount;//背景图
@property(nonatomic,retain)UIImageView *headImg;//头像
@property(nonatomic, retain)UILabel *name;//名字
@property(nonatomic, retain)UITableView *tableView;
@end

@implementation MyAccountViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initView];
    
}


#pragma mark - 视图初始化
-(void)initView{
    
    _viewOfAccount = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MSWIDTH, MSWIDTH /2)];
    _viewOfAccount.image= [UIImage imageNamed:@"背景"];
    [self.view addSubview:_viewOfAccount];

    //设置
    UIButton *setting = [UIButton buttonWithType:UIButtonTypeCustom];
    [setting setBackgroundImage: [UIImage imageNamed:@"设置"] forState:UIControlStateNormal];
    setting.frame = CGRectMake(MSWIDTH - 40, 30, 25, 25);
    [setting addTarget:self action:@selector(pushset) forControlEvents:UIControlEventTouchUpInside];
    [_viewOfAccount addSubview:setting];
    _viewOfAccount.userInteractionEnabled = YES;
    
    _name = [[UILabel alloc]initWithFrame:CGRectMake(MSWIDTH/2 - 40, 30, 80, 25)];
    _name.textAlignment = NSTextAlignmentCenter;
    _name.font = [UIFont systemFontOfSize:15];
    _name.textColor = [UIColor whiteColor];
    _name.text = @"苏坡boy";
    [_viewOfAccount addSubview:_name];
    

    _headImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSWIDTH/2 - 40, MSWIDTH/2/2 - 40 +20, 80, 80)];
    _headImg.layer.masksToBounds = YES;
    _headImg.layer.cornerRadius = 40.0f;
    _headImg.image = [UIImage imageNamed:@"touxiang"];
    [_viewOfAccount addSubview:_headImg];
    
    //适配iPhone X
    if (MSHIGHT == 812) {
        setting.frame = CGRectMake(MSWIDTH - 40, 50, 25, 25);
        _name.frame = CGRectMake(MSWIDTH/2 - 40, 50, 80, 25);
        _viewOfAccount.frame = CGRectMake(0, 0, MSWIDTH, MSWIDTH /2+30);
        _headImg.frame = CGRectMake(MSWIDTH/2 - 40, MSWIDTH/2/2 - 40 +40, 80, 80);
    }
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, MSWIDTH *1/2, MSWIDTH, MSHIGHT * 1/2) style:UITableViewStylePlain];
    //适配iPhone X
    if (MSHIGHT == 812) {
        _tableView.frame = CGRectMake(0, MSWIDTH*1/2 +30, MSWIDTH, MSHIGHT*1/2);
    }
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.scrollEnabled= NO;

    [self.tableView registerClass:[MyAccountCell class] forCellReuseIdentifier:@"pool"];

}

- (void)pushset{
    
    SetViewController *set = [[SetViewController alloc]init];
    
    [self.navigationController pushViewController:set animated:NO];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pool"];
    NSArray *labelArr = MYACCOUNDLABELARR;
    NSArray *iconArr = MYACCOUNTICONARR;
    cell.labelText = labelArr[indexPath.row];
    cell.icon = iconArr[indexPath.row];
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        AssoicateViewController *associate = [[AssoicateViewController alloc]init];
        [self.navigationController pushViewController:associate animated:NO];
    }else if (indexPath.row == 1){
        
        HistoryPlantsViewController *history = [[HistoryPlantsViewController alloc]init];
        [self.navigationController pushViewController:history animated:NO];
        
    }else if (indexPath.row == 2){
        
        CommonQuestionViewController *common = [[CommonQuestionViewController alloc]init];
        [self.navigationController pushViewController:common animated:NO];
        
    }
}




@end
