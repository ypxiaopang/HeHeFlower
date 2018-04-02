//
//  AddEquipViewController.m
//  Flower
//
//  Created by Apple on 2018/3/13.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "AddEquipViewController.h"
#import "Animations.h"
#import "BluetoothTableViewCell.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "NetWorkClient.h"
#import "AddPlantViewController.h"
@interface AddEquipViewController ()<CustomerAnimationsDelegate,CBCentralManagerDelegate,CBPeripheralDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, retain)UILabel *label;
@property(nonatomic, retain)UIButton *again;
@property(nonatomic, retain)UIButton *question;
@property(nonatomic, retain)UIButton *addPlant;
@property(nonatomic, retain)UIView *animationView;
@property(nonatomic, retain)Animations *animations;
@property(nonatomic, retain)CAShapeLayer *arcLayer;
@property(nonatomic, retain)CBCentralManager *centralManager;
@property(nonatomic, retain)CBPeripheral *peripheral;
@property(nonatomic, assign)BOOL bluetoothState;
@property(nonatomic, retain)NSMutableDictionary *dicOfBluetooth;
@property(nonatomic, retain)NSMutableArray *arrOfBluetooth;
@property(nonatomic, retain)UITableView *bluetoothView;
@end

@implementation AddEquipViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _arrOfBluetooth = [NSMutableArray array];
//    [_arrOfBluetooth addObject:@"obj1"];
//    [_arrOfBluetooth addObject:@"obj2"];
    [self addArcLayer];
    _centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];
    [_peripheral setDelegate:self];
    self.tabBarController.tabBar.hidden = YES;
    [self initView];
    [self createTableView];
    [self createAddPlantView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)initView{

    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(20, 30, 15, 20);
    [back setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
    self.navigationController.navigationBar.alpha=1;
    self.view.backgroundColor = [ColorTools colorWithHexString:@"54b787"];
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(MSWIDTH/2 - 100,  200,200, 300)];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font =  [UIFont systemFontOfSize:16 weight:1.5];
    _label.numberOfLines = 0;
    _label.textColor = [UIColor whiteColor];
    [self.view addSubview:_label];
    
    _question = [UIButton buttonWithType: UIButtonTypeCustom];
    _question.frame = CGRectMake(15, MSHIGHT - 50, MSWIDTH/2- 30, 40);
    _question.layer.masksToBounds = YES;
    _question.layer.borderWidth = 0.5f;
   _question.layer.borderColor = [UIColor whiteColor].CGColor;
    _question.layer.cornerRadius = 20.0f;
    [_question setTitle:@"常见问题" forState:UIControlStateNormal];
    [self.view addSubview:_question];
    _question.hidden = YES;
    [_question addTarget:self action:@selector(showQuestion) forControlEvents:UIControlEventTouchUpInside];
    
    _again = [UIButton buttonWithType: UIButtonTypeCustom];
    _again.frame = CGRectMake(MSWIDTH/2 +15, MSHIGHT - 50, MSWIDTH/2- 30, 40);
    _again.layer.masksToBounds = YES;
    _again.layer.borderWidth = 0.5f;
    _again.layer.borderColor = [UIColor whiteColor].CGColor;
    _again.layer.cornerRadius = 20.0f;
    [_again setTitle:@"重试" forState:UIControlStateNormal];
    [self.view addSubview:_again];
    _again.hidden = YES;
    [_again addTarget:self action:@selector(tryReconnect) forControlEvents:UIControlEventTouchUpInside];
    
    _addPlant = [UIButton buttonWithType:UIButtonTypeCustom];
    _addPlant.frame = CGRectMake(MSWIDTH/3/2, MSHIGHT - 60, MSWIDTH/3*2, 50);
    _addPlant.layer.masksToBounds = YES;
    _addPlant.layer.borderWidth = 0.5f;
    _addPlant.layer.cornerRadius = 10.f;
    _addPlant.layer.borderColor = [UIColor whiteColor].CGColor;
    _addPlant.backgroundColor = [UIColor whiteColor];
    [_addPlant setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
    [_addPlant setTitle:@"添加植物" forState:UIControlStateNormal];
    [self.view addSubview:_addPlant];
    [_addPlant addTarget:self action:@selector(addPlantForEqu) forControlEvents:UIControlEventTouchUpInside];
    _addPlant.hidden = YES;
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:NO];
}


- (void)showQuestion{
    
}

- (void)tryReconnect{

    if ([[NetWorkClient sharedInstance] isNetworkEnabled]) {
        if (!_animations) {
            [self createAnimation];
        }
        [_animations initCirCleAnimationWithLayerWithView:_animationView isRemovedOnCompletion:YES duration:5.0f];
        [_centralManager scanForPeripheralsWithServices:nil options:nil];
    }else{
        _label.text = @"网络未连接";
    }


}

- (void)addPlantForEqu{
    
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    [dic setObject:@"5" forKey:@"user_id"];
//    [dic setObject:@"35" forKey:@"OPT"];
//
//    [[NetWorkClient sharedInstance]requestParameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"result=%@",responseObject);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//
//    }];
    AddPlantViewController *plant = [[AddPlantViewController alloc] init];
    [self presentViewController:plant animated:YES completion:^{
        
    }];
    
}

- (void)createAddPlantView{

    
}

- (void)createTableView{
    _bluetoothView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, MSWIDTH, MSHIGHT - 60) style:UITableViewStylePlain];
    _bluetoothView.backgroundColor = [ColorTools colorWithHexString:@"54b787"];
    [_bluetoothView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"bluetooth"];
    _bluetoothView.delegate = self;
    _bluetoothView.dataSource = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _arrOfBluetooth.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"bluetooth"];
    cell.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"请选择要连接的设备:";
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.font = [UIFont fontWithName:@"Courier New" size:15];
        
    }else{
        cell.textLabel.text = @"护花使者";
        cell.textLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:17];
    }
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 35;
    }else{
        return 50;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row != 0) {
        _peripheral = _arrOfBluetooth[indexPath.row - 1];
        [_centralManager connectPeripheral:_peripheral options:nil];
        NSLog(@"UUID=%@",_peripheral.identifier);

        
    }
    
}

- (void)createAnimation{
    _animations=[[Animations alloc] init];
    _animationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    _animationView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.4];
    _animationView.layer.cornerRadius = 10.0f;
    _animationView.layer.masksToBounds = YES;
    [self.view addSubview:_animationView];
    _animations.delegate = self;
    [_animations initCirCleAnimationWithLayerWithView:_animationView isRemovedOnCompletion:YES duration:5.0f];
    
}

- (void)addArcLayer{
    /**
     *  加一层 背景
     */
    UIBezierPath *path=[UIBezierPath bezierPath];
    CGRect rect=[UIScreen mainScreen].bounds;
    int value = (arc4random() % 2);
    
    [path addArcWithCenter:CGPointMake(rect.size.width/2,rect.size.height/2)
                    radius:rect.size.width/2-50
                startAngle:0
                  endAngle:2*M_PI
                 clockwise:value];
    _arcLayer = [CAShapeLayer layer];
    _arcLayer.path = path.CGPath;//46,169,230
    _arcLayer.fillColor = [ColorTools colorWithHexString:@"54b787"].CGColor;
    _arcLayer.strokeColor = [UIColor colorWithWhite:1 alpha:0.7].CGColor;
    _arcLayer.lineWidth = 3;
    _arcLayer.frame = self.view.frame;
    [self.view.layer insertSublayer:_arcLayer atIndex:0];
    self.view.backgroundColor = [ColorTools colorWithHexString:@"54b787"];

    
}



//CustomerAnimationsDelegate
- (void)didStartAnimation{

    _question.hidden = YES;
    _again.hidden = YES;
    _addPlant.hidden = YES;
    _label.text = @"正在扫描...请将手机与设备保持在10cm以内";
    
}

- (void)didFinishAnimation{
    
    if (_bluetoothState) {
        if ([[NetWorkClient sharedInstance] isNetworkEnabled]) {
            if (_arrOfBluetooth.count > 0) {
                if (_arrOfBluetooth.count == 1) {
                    _peripheral = self.arrOfBluetooth[0];
                    [_centralManager connectPeripheral:_peripheral options:nil];
                }else{
                    [self.view addSubview:_bluetoothView];
                }
            }else{
                _question.hidden = NO;
                _again.hidden = NO;
                _label.text = @"未查找到可用的蓝牙设备";
            }
            
        }else{
            _label.text = @"网络未连接";
            _again.hidden = NO;
            _question.hidden = NO;
        }

        [_centralManager stopScan];

    }
    
}


- (void)centralManagerDidUpdateState:(nonnull CBCentralManager *)central {
    if (central.state == CBManagerStatePoweredOn) {
        NSLog(@"connect----------------");
        _bluetoothState = true;
        BOOL connect = [[NetWorkClient sharedInstance] isNetworkEnabled];
        if (!_animations) {
            [self createAnimation];
        }
        if (connect) {
            [_centralManager scanForPeripheralsWithServices:nil options:nil];
        }else{
            [_centralManager stopScan];
            _label.text = @"网络未连接";
            _question.hidden = NO;
            _again.hidden = NO;
            _bluetoothState = true;
            [_animationView removeFromSuperview];
            _animations = nil;
        }
        
    }else{
        NSLog(@"disconnect------------");
        [_centralManager stopScan];
        _label.text = @"蓝牙未开启";
        _question.hidden = YES;
        _again.hidden = YES;
        _bluetoothState = false;
        [_animationView removeFromSuperview];
        _animations = nil;
    }

}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSLog(@"外设的名称 == %@,外设 == %@ 信号强度 == %@",peripheral.name,peripheral,RSSI);
    if (peripheral == nil) {
        return;
    }
    if((__bridge CFUUIDRef )peripheral.identifier == NULL) return;
    
    if(peripheral.name == nil || peripheral.name.length < 1) return;
    if ([peripheral.name containsString:@"ST-BLE"]) {
        if(![self.arrOfBluetooth containsObject:peripheral]){
            [self.arrOfBluetooth addObject:peripheral];
        }
        NSLog(@"searching.............");
        
    }
    
}

-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    [_animationView removeFromSuperview];
    [_bluetoothView removeFromSuperview];
    _animations = nil;
    _label.text = @"已经成功连接设备";
    _addPlant.hidden = NO;

    //给服务器发送蓝牙UUID
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSLog(@"UUID=%@",[peripheral.identifier UUIDString]);
    [dic setObject:@"5" forKey:@"user_id"];
    [dic setObject:[peripheral.identifier UUIDString] forKey:@"identify"];
    [dic setObject:@"34" forKey:@"OPT"];
    [[NetWorkClient sharedInstance]requestParameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"result=%@",responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        _label.text = @"连接失败,请重试";
        _again.hidden = NO;
        _question.hidden = NO;
    }];
    
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
//    _label.text = @"蓝牙连接断开";
//    _question.hidden = NO;
//    _again.hidden = NO;
//    _addPlant.hidden = YES;
//    [_arrOfBluetooth removeAllObjects];
}

@end
