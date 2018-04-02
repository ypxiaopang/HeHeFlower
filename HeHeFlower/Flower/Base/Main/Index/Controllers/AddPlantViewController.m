//
//  AddPlantViewController.m
//  Flower
//
//  Created by 张营营 on 2018/3/28.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "AddPlantViewController.h"
#import "NavBar.h"
#import "UIButton+KK.h"


@interface AddPlantViewController ()<NavBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, retain)UITableView *addPlantView;

@property(nonatomic, retain)NavBar *navBar;

@end

@implementation AddPlantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [ColorTools colorWithHexString:@"54b787"];
    [self barConfig];
    [self createTableView];
}

- (void)barConfig{
    _navBar = [[NavBar alloc]initWithTitle:@"添加植物" WithLeftImage:[UIImage imageNamed:@"back"] WithRightImage:nil];
    _navBar.delegate = self;

//    CGSize rightBtnSize = [_navBar.leftBtn sizeWithTitle:@"" font:[UIFont systemFontOfSize:15.0f]];
    
//    [_navBar.leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
//    [_navBar.leftBtn setContentEdgeInsets:UIEdgeInsetsMake(0, -rightBtnSize.width/2, 0, 0)];
//    [_navBar.leftBtn setTitleColor:baseOrangeColor forState:UIControlStateNormal];
//    [_navBar.leftBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self.view addSubview:_navBar];
    
}

- (void)leftItemClick{

    
}

- (void)rightItemClick {
    
    
}

- (void)createTableView{
    _addPlantView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, MSWIDTH, MSHIGHT - 64) style:UITableViewStylePlain];
    _addPlantView.backgroundColor = [ColorTools colorWithHexString:@"54b787"];
    _addPlantView.delegate = self;
    _addPlantView.dataSource = self;
    [self.view addSubview:_addPlantView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"addPlant"];
    return cell;
    
}



@end
