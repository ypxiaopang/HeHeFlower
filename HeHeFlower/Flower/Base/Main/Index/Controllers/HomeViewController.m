//  HomeViewController.m
//  JulijrP2P
//
//  Created by 韩 立 on 2017/1/20.
//  Copyright © 2017年 聚力金服网络科技有限公司. All rights reserved.
//
//首页

#import "HomeViewController.h"
#import "NavBar.h"
#import "HomeCell.h"
#import "UIButton+KK.h"
#import "RealTimeViewController.h"
#import "MonitoringViewController.h"
#import "AddEquipViewController.h"

@interface HomeViewController()<NavBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)NavBar *navBar;
@property (strong, nonatomic)  UITableView *tableView;

@end

@implementation HomeViewController

#pragma mark - 视图控制器生命周期
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createSubViews];
}

- (void)createSubViews{
    
    _navBar = [[NavBar alloc] initWithTitle:@"我的智能设备" WithLeftImage:nil WithRightImage:[UIImage imageNamed:@"jiahao"]];
    _navBar.delegate = self;
    [self.view addSubview:_navBar];

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, MSWIDTH, MSHIGHT-NAVBAR_HEIGHT) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[HomeCell class] forCellReuseIdentifier:@"pool"];

    
    //设置上下拉刷新
    
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    NSArray *imageArr = @[[UIImage imageNamed:@"pulling_anmi_0"],[UIImage imageNamed:@"pulling_anmi_1"],[UIImage imageNamed:@"pulling_anmi_2"],[UIImage imageNamed:@"pulling_anmi_3"]];
    [header setImages:imageArr duration:0.7 forState:MJRefreshStatePulling];
    [header setImages:imageArr duration:0.7 forState:MJRefreshStateRefreshing];
    header.stateLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:9];
    header.stateLabel.textColor = [UIColor colorWithRed:172/255.0 green:172/255.0 blue:172/255.0 alpha:1];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;

    if (@available(iOS 11.0,*)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
}

- (void)loadNewData{
     [self.tableView.mj_header endRefreshing];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pool"];
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        MonitoringViewController *monitor = [[MonitoringViewController alloc]init];
        self.tabBarController.tabBar.hidden  = YES;
        [self.navigationController pushViewController:monitor animated:NO];
    }else if (indexPath.row == 1){
        
        RealTimeViewController *real = [[RealTimeViewController alloc]init];
        [self.navigationController pushViewController:real animated:NO];

        
    }
    
    
}


- (void)nextItemClick
{
    AddEquipViewController *add = [[AddEquipViewController alloc]init];
    [self.navigationController pushViewController:add animated:NO];
}



@end
