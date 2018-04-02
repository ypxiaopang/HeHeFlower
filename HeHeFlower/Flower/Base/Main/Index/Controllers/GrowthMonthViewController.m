//
//  GrowthMonthViewController.m
//  Flower
//
//  Created by Apple on 2018/3/10.
//  Copyright © 2018年 Apple. All rights reserved.
//



#import "GrowthDayViewController.h"
#import "NavBar.h"
#import "UIButton+KK.h"
#import "GrowthWeekViewController.h"
#import "GrowthMonthViewController.h"
#import "ZhuView.h"
@interface GrowthMonthViewController ()<NavBarDelegate,UIScrollViewDelegate>
@property(nonatomic, strong)NavBar *navBar;
@property(nonatomic, strong)UIScrollView *sc;
@end

@implementation GrowthMonthViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _sc = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, MSWIDTH, 800)];
    _sc.contentSize = CGSizeMake(0, 1000);
    
    [self.view addSubview:_sc];
    _sc.delegate = self;
    _sc.scrollEnabled = YES;
    [_sc setShowsHorizontalScrollIndicator:NO];
    _sc.showsVerticalScrollIndicator = FALSE;
    _sc.showsHorizontalScrollIndicator = FALSE;
    _sc.bounces = NO;
    if (@available(iOS 11.0,*)) {
        _sc.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _sc.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _sc.scrollIndicatorInsets = _sc.contentInset;
    }
    [self initView];
    [self createCalendar];
}

- (void)initView{
    _navBar = [[NavBar alloc]initWithTitle:@"月成长报告" WithLeftImage:nil WithRightImage:[UIImage imageNamed:@"日历"]];
    _navBar.delegate = self;

    [self.view addSubview:_navBar];
    self.navigationController.navigationBar.alpha=1;
    
    _lasted = [[UILabel alloc]initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, MSWIDTH, 30)];
    _lasted.backgroundColor = [UIColor whiteColor];
    _lasted.textColor = [UIColor lightGrayColor];
    _lasted.font = [UIFont fontWithName:@"STHeitiSC-Light" size:12];
    _lasted.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_lasted];
    _lasted.text = @"最新数据 2018-03-10";
    
    _zuo = [[UIImageView alloc]initWithFrame:CGRectMake(5, 43, 15, 10)];
    _zuo.image = [UIImage imageNamed:@"左箭头"];
    [_sc addSubview:_zuo];
    _qian = [[UILabel alloc]initWithFrame:CGRectMake(20,40, 50, 15)];
    _qian.text = @"前一月";
    _qian.textAlignment = NSTextAlignmentCenter;
    _qian.textColor = [UIColor lightGrayColor];
    _qian.font =[UIFont fontWithName:@"STHeitiSC-Light" size:15];
    [_sc addSubview:_qian];
    
    
    _you = [[UIImageView alloc]initWithFrame:CGRectMake(MSWIDTH - 20, 43, 15, 10)];
    _you.image = [UIImage imageNamed:@"右箭头-2"];
    [_sc addSubview:_you];
    _hou = [[UILabel alloc]initWithFrame:CGRectMake(MSWIDTH - 70,40, 50, 15)];
    _hou.text = @"后一月";
    _hou.textAlignment = NSTextAlignmentCenter;
    _hou.textColor = [UIColor lightGrayColor];
    _hou.font =[UIFont fontWithName:@"STHeitiSC-Light" size:15];
    [_sc addSubview:_hou];
    
    
    _date = [[UILabel alloc]initWithFrame:CGRectMake(MSWIDTH/2 - 50, 40, 100, 15)];
    _date.textAlignment = NSTextAlignmentCenter;
    _date.text= @"03月10日";
    _date.font = [UIFont fontWithName:@"STHeitiSC-Light" size:15];
    [_sc addSubview:_date];
    _date.textColor = [UIColor lightGrayColor];
    ZhuView *view1 = [[ZhuView alloc]initWithFrame:CGRectMake(0, 150, MSWIDTH, 200) :@[@"1",@"",@"",@"",@"",@"",@"7",@"",@"",@"",@"",@"",@"13",@"",@"",@"",@"",@"",@"19",@"",@"",@"",@"",@"",@"25",@"",@"",@"",@"",@"30"]:@[@"60",@"90",@"100",@"80",@"20",@"30",@"40",@"60",@"90",@"10",@"80",@"20",@"30",@"60",@"90",@"10",@"80",@"20",@"30",@"60",@"90",@"10",@"80",@"20",@"12",@"83",@"90",@"23",@"23",@"87"]:[ColorTools colorWithHexString:@"f7a9a7"]];
    [_sc addSubview:view1];
    UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 103, 20, 20)];
    img1.image = [UIImage imageNamed:@"温度-1"];
    [_sc addSubview:img1];
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(35, 100, 30, 30)];
    label1.text  = @"温度";
    label1.textColor = [UIColor lightGrayColor];
    label1.font = [UIFont fontWithName:@"STHeitiSC-Light" size:10];
    [_sc addSubview:label1];
    
    
    
    
    
    
    ZhuView *view2 = [[ZhuView alloc]initWithFrame:CGRectMake(0, 350, MSWIDTH, 200) :@[@"1",@"",@"",@"",@"",@"6",@"",@"",@"",@"",@"",@"12",@"",@"",@"",@"",@"",@"18",@"",@"",@"",@"",@"",@"24"]:@[@"60",@"90",@"100",@"80",@"20",@"30",@"40",@"60",@"90",@"10",@"80",@"20",@"30",@"60",@"90",@"10",@"80",@"20",@"30",@"60",@"90",@"10",@"80",@"20"]:[ColorTools colorWithHexString:@"a6d5f3"] ];
    [_sc addSubview:view2];
    
    UIImageView *img2 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 303, 20, 20)];
    img2.image = [UIImage imageNamed:@"水分"];
    [_sc addSubview:img2];
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(35, 300, 30, 30)];
    label2.text  = @"水分";
    label2.textColor = [UIColor lightGrayColor];
    label2.font =[UIFont fontWithName:@"STHeitiSC-Light" size:10];
    [_sc addSubview:label2];
    
    ZhuView *view3 = [[ZhuView alloc]initWithFrame:CGRectMake(0, 550, MSWIDTH, 200) :@[@"1",@"",@"",@"",@"",@"6",@"",@"",@"",@"",@"",@"12",@"",@"",@"",@"",@"",@"18",@"",@"",@"",@"",@"",@"24"]:@[@"60",@"90",@"100",@"80",@"20",@"30",@"40",@"60",@"90",@"10",@"80",@"20",@"30",@"60",@"90",@"10",@"80",@"20",@"30",@"60",@"90",@"10",@"80",@"20"] :[ColorTools colorWithHexString:@"ffcf99"]];
    [_sc addSubview:view3];
    
    UIImageView *img3 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 503, 20, 20)];
    img3.image = [UIImage imageNamed:@"光照"];
    [_sc addSubview:img3];
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(40, 500, 40, 30)];
    label3.text  = @"光照";
    label3.textColor = [UIColor lightGrayColor];
    label3.font = [UIFont fontWithName:@"STHeitiSC-Light" size:10];
    [_sc addSubview:label3];
    
    
    
    
    UITapGestureRecognizer * sigleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture)];
    sigleTap.numberOfTapsRequired = 1;
    
    [_sc addGestureRecognizer:sigleTap];
    

    
}
- (void)createCalendar{
    
    
    _calendar = [[UIView alloc]initWithFrame:CGRectMake(MSWIDTH - 110, NAVBAR_HEIGHT - 10, 100, 100)];
    _calendar.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.7];
    _calendar.layer.masksToBounds = YES;
    _calendar.layer.cornerRadius = 5.0f;
    _calendar.userInteractionEnabled = YES;
    [self.view addSubview:_calendar];
    _calendar.hidden = YES;
    
    _ri = [UIButton buttonWithType: UIButtonTypeCustom];
    [_ri setTitle:@"| 日成长报告" forState:UIControlStateNormal];
    _ri.backgroundColor = [UIColor clearColor];
    _ri.frame = CGRectMake(0, 0, 100, 33);
    _ri.titleLabel.font = [UIFont systemFontOfSize:12];
    [_ri addTarget:self action:@selector(growthRi) forControlEvents:UIControlEventTouchUpInside];
    [_calendar addSubview:_ri];
    
    _week = [UIButton buttonWithType:UIButtonTypeCustom];
    [_week setTitle:@"| 周成长报告" forState:UIControlStateNormal];
    _week.backgroundColor = [UIColor clearColor];
    _week.frame = CGRectMake(0, 33, 100, 33);
    _week.titleLabel.font =[UIFont systemFontOfSize:12];
    [_week addTarget:self action:@selector(growthWeek) forControlEvents:UIControlEventTouchUpInside];
    [_calendar addSubview:_week];
    
    _month = [UIButton buttonWithType: UIButtonTypeCustom];
    [_month setTitle:@"| 月成长报告" forState:UIControlStateNormal];
    _month.backgroundColor = [UIColor clearColor];
    _month.frame = CGRectMake(0, 66, 100, 33);
    _month.titleLabel.font = [UIFont systemFontOfSize:12];
    [_month addTarget:self action:@selector(growthMonth) forControlEvents:UIControlEventTouchUpInside];
    [_calendar addSubview:_month];
    
  
    
}

- (void)growthRi{
    
    GrowthDayViewController *grow = [[GrowthDayViewController alloc]init];
    [self.navigationController pushViewController:grow animated:NO];
}

- (void)growthWeek{
        GrowthWeekViewController *grow = [[GrowthWeekViewController alloc]init];
        [self.navigationController pushViewController:grow animated:NO];
    
    
}

- (void)growthMonth{
    
//    GrowthMonthViewController *grow = [[GrowthMonthViewController alloc]init];
//    [self.navigationController pushViewController:grow animated:NO];
     _calendar.hidden = YES;
    
}
-(void)handleTapGesture
{
    if ([_calendar isKindOfClass:[UIView class]]) {
        _calendar.hidden = YES;
    }
    
}
- (void)rightItemClick{
    if (_calendar.hidden == YES) {
        _calendar.hidden = NO;
    }else{
        
        _calendar.hidden = YES;
    }
}

- (void)leftItemClick{
    UINavigationController *nav = self.navigationController.viewControllers[1];
    [self.navigationController popToViewController:nav animated:YES];
    
    
}
@end
