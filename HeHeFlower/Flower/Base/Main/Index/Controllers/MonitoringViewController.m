//
//  MonitoringViewController.m
//  Flower
//
//  Created by Apple on 2018/3/7.
//  Copyright © 2018年 Apple. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "MonitoringViewController.h"
#import "NavBar.h"
#import "UIButton+KK.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "GrowthDayViewController.h"
#import "GrowthWeekViewController.h"
#import "GrowthMonthViewController.h"
#define crc16 0x8005
@interface MonitoringViewController ()<NavBarDelegate,CBPeripheralDelegate,CBCentralManagerDelegate>
@property(nonatomic, strong)NavBar *navBar;
@property(nonatomic, strong)CBCentralManager *centralManager;
@property(nonatomic, strong)CBPeripheral *peripheral;
@property(nonatomic, strong)NSMutableArray *arrBlue;
@property(nonatomic, strong)NSTimer *connentTimer;
@property(nonatomic, strong)CBCharacteristic *Characteristic;
@property(nonatomic, strong) NSArray<CBCharacteristic *> *selfCharacteristics;
@property(nonatomic, assign)NSInteger requestType;
@property(nonatomic, copy)NSString *humidity;//湿度
@property(nonatomic, copy)NSString *temperature;//温度
@property(nonatomic, copy)NSString *sun;//光照度
@property(nonatomic, assign)float length;//240条
@end

@implementation MonitoringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
 _arrBlue = [NSMutableArray array];
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];
    [_peripheral setDelegate:self];
    [self initView];

    [self initInformation];
    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:5.0f];
   // [self createCalendar];

}



- (void)delayMethod{
    
    if ([_connect.text isEqualToString:@"正在连接中..."]) {
        _connect.text = @"连接失败";
        _state.image = [UIImage imageNamed:@"失败"];
        _again.hidden = NO;
        _centralManager = nil;
    }
    
}


- (void)initInformation{

    UIView *ViewInfo = [[UIView alloc]initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, MSWIDTH, 200)];
    [self.view addSubview:ViewInfo];


    _name = [[UILabel alloc]initWithFrame:CGRectMake(30, 20, 80, 40)];
    _name.text = @"23";
    _name.textColor = [ColorTools colorWithHexString:@"646190"];
    _name.text = @"蝴蝶兰";
    _name.font = [UIFont fontWithName:@"STHeitiSC-Light" size:25];
    [ViewInfo addSubview:_name];

    UIImageView *jiance = [[UIImageView alloc]initWithFrame:CGRectMake(30, 62, 15, 15)];

    jiance.image = [UIImage imageNamed:@"监测"];
    [ViewInfo addSubview:jiance];


    _day = [[UILabel alloc]initWithFrame:CGRectMake(53, 60, 80, 20)];
    _day.font = [UIFont fontWithName:@"STHeitiSC-Light" size:13];
    _day.textColor = [UIColor lightGrayColor];
    _day.text = @"已监测0天";
    [ViewInfo addSubview:_day];

    _state = [[UIImageView alloc]initWithFrame:CGRectMake(31, 86, 12, 12)];
    _state.image = [UIImage imageNamed:@"连接"];
    [ViewInfo addSubview:_state];

    _connect = [[UILabel alloc]initWithFrame:CGRectMake(53, 82, 80, 20)];
    _connect.font = [UIFont fontWithName:@"STHeitiSC-Light" size:12];
    _connect.textColor = [UIColor lightGrayColor];
    _connect.text = @"正在连接中...";
    [ViewInfo addSubview:_connect];


    _img = [[UIImageView alloc]initWithFrame:CGRectMake(MSWIDTH -100, 25, 45, 50)];
    _img.image = [UIImage imageNamed:@"蝴蝶兰"];
    [ViewInfo addSubview:_img];

    _jiantou = [[UIImageView alloc]initWithFrame:CGRectMake(MSWIDTH - 45, 40, 17, 17)];
    _jiantou.image = [UIImage imageNamed:@"右箭头-2"];
    [ViewInfo addSubview:_jiantou];
    
    _again = [UIButton buttonWithType:UIButtonTypeCustom];
    _again.frame = CGRectMake(MSWIDTH - 105, 82, 60, 20);
    [_again setTitle:@"重新连接" forState:UIControlStateNormal];
        _again.titleLabel.textAlignment = NSTextAlignmentCenter;
    _again.titleLabel.font  = [UIFont fontWithName:@"STHeitiSC-Light" size:10];
    [_again setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _again.layer.masksToBounds = YES;
    _again.layer.cornerRadius = 5.0f;
    [_again.layer setBorderWidth:0.5f];
    [_again.layer setBorderColor:[UIColor lightGrayColor].CGColor ];
    [ViewInfo addSubview:_again];
    [_again addTarget:self action:@selector(againConnect) forControlEvents:UIControlEventTouchUpInside];
    _again.hidden = YES;

}
- (void)againConnect{
    
    _arrBlue = [NSMutableArray array];
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];
    [_peripheral setDelegate:self];
       [self performSelector:@selector(delayMethod) withObject:nil afterDelay:5.0f];
}

- (void)initView{
    self.view.backgroundColor = [ColorTools colorWithHexString:@"#ebeff2"];
    UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, MSWIDTH, MSHIGHT - NAVBAR_HEIGHT)];
    img1.image = [UIImage imageNamed:@"背景图-1"];
    [self.view addSubview: img1];
    _navBar = [[NavBar alloc]initWithTitle:@"实时监测" WithLeftImage:nil WithRightImage:[UIImage imageNamed:@"主页_成长记录"]];
    _navBar.delegate = self;

    [self.view addSubview:_navBar];
    self.navigationController.navigationBar.alpha=1;

    //第一块
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(15, 200, MSWIDTH - 30, 80)];
    view1.layer.cornerRadius = 5.0f;
    view1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view1];

    UIImageView *temp = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 30, 30)];
    temp.image = [UIImage imageNamed:@"温度-1"];
    [view1 addSubview:temp];

    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(26, 60, 40, 10)];
    label1.text = @"温度";
    label1.textColor = [UIColor lightGrayColor];
    label1.font =  [UIFont fontWithName:@"STHeitiSC-Light" size:10];
    [view1 addSubview:label1];
    UILabel *descriptor1 = [[UILabel alloc]initWithFrame:CGRectMake(MSWIDTH - 30-180, 50, 150, 10)];
    descriptor1.textAlignment = NSTextAlignmentRight;
    descriptor1.text = @"5~32(°C)";
    descriptor1.font = [UIFont fontWithName:@"STHeitiSC-Light" size:8];
    descriptor1.textColor = [UIColor lightGrayColor];
    [view1 addSubview:descriptor1];
    _triangle = [[UIImageView alloc]initWithFrame:CGRectMake(MSWIDTH - 30 - 27, 33, 7, 7)];
   // _triangle.image = [UIImage imageNamed:@"三角1"];
    [view1 addSubview:_triangle];
    _value1 = [[UILabel alloc]initWithFrame:CGRectMake(MSWIDTH - 57 -50, 25, 50, 20)];
    _value1.textColor = [ColorTools colorWithHexString:@"#ea5413"]
;
    _value1.text = @"0";
    _value1.textAlignment = NSTextAlignmentCenter;
    [view1 addSubview:_value1];
    _value1.font = [UIFont systemFontOfSize:20];

    //第二块
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(15, 300, MSWIDTH - 30, 80)];
    view2.layer.cornerRadius = 5.0f;
    view2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view2];
    UIImageView *temp1 = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 30, 30)];
    temp1.image = [UIImage imageNamed:@"水分"];
    [view2 addSubview:temp1];
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(26, 60, 40, 10)];
    label2.text = @"水分";
    label2.textColor = [UIColor lightGrayColor];
    label2.font =  [UIFont fontWithName:@"STHeitiSC-Light" size:10];
    [view2 addSubview:label2];
    UILabel *descriptor2 = [[UILabel alloc]initWithFrame:CGRectMake(MSWIDTH - 30-180, 50, 150, 10)];
    descriptor2.textAlignment = NSTextAlignmentRight;
    descriptor2.text = @"15~16( % )";
    descriptor2.font = [UIFont fontWithName:@"STHeitiSC-Light" size:8];
    descriptor2.textColor = [UIColor lightGrayColor];
    [view2 addSubview:descriptor2];
    _triangle2 = [[UIImageView alloc]initWithFrame:CGRectMake(MSWIDTH - 30 - 27, 33, 7, 7)];
    //_triangle2.image = [UIImage imageNamed:@"三角1"];
    [view2 addSubview:_triangle2];
    _value2 = [[UILabel alloc]initWithFrame:CGRectMake(MSWIDTH - 57 -50, 25, 50, 20)];
    _value2.textColor = [ColorTools colorWithHexString:@"#ea5413"]
    ;
    _value2.text = @"0";
    _value2.textAlignment = NSTextAlignmentCenter;
    [view2 addSubview:_value2];
    _value2.font = [UIFont systemFontOfSize:20];



    //第三块
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(15, 400, MSWIDTH - 30, 80)];
    view3.layer.cornerRadius = 5.0f;
    view3.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view3];

    UIImageView *temp2 = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 30, 30)];
    temp2.image = [UIImage imageNamed:@"光照"];
    [view3 addSubview:temp2];
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(26, 60, 40, 10)];
    label3.text = @"光照";
    label3.textColor = [UIColor lightGrayColor];
    label3.font =  [UIFont fontWithName:@"STHeitiSC-Light" size:10];
    [view3 addSubview:label3];
    UILabel *descriptor3 = [[UILabel alloc]initWithFrame:CGRectMake(MSWIDTH - 30-180, 50, 150, 10)];
    descriptor3.textAlignment = NSTextAlignmentRight;
    descriptor3.text = @"600~18000( lux )";
    descriptor3.font = [UIFont fontWithName:@"STHeitiSC-Light" size:8];
    descriptor3.textColor = [UIColor lightGrayColor];
    [view3 addSubview:descriptor3];
    _triangle3 = [[UIImageView alloc]initWithFrame:CGRectMake(MSWIDTH - 30 - 27, 33, 7, 7)];
   // _triangle3.image = [UIImage imageNamed:@"三角1"];
    [view3 addSubview:_triangle3];
    _value3 = [[UILabel alloc]initWithFrame:CGRectMake(MSWIDTH - 57 -50, 25, 50, 20)];
    _value3.textColor = [UIColor lightGrayColor]    ;
    _value3.text = @"0";
    _value3.textAlignment = NSTextAlignmentCenter;
    [view3 addSubview:_value3];
    _value3.font = [UIFont systemFontOfSize:20];







}
- (void)leftItemClick{
    [_connentTimer invalidate];
    _connentTimer = nil;
    if ([_connect.text isEqualToString:@"连接成功"]) {
           [_centralManager cancelPeripheralConnection:_peripheral];
    }
 
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)rightItemClick{
    [_connentTimer invalidate];
    _connentTimer = nil;
    if ([_connect.text isEqualToString:@"连接成功"]) {
        [_centralManager cancelPeripheralConnection:_peripheral];
    }
    GrowthDayViewController *grow = [[GrowthDayViewController alloc]init];
    [self.navigationController pushViewController:grow animated:NO];
   
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if ([_calendar isKindOfClass:[UIView class]]) {
        _calendar.hidden = YES;
    }
}

- (void)startSend{
    
    self.connentTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(realTime) userInfo:nil repeats:YES];
    [self.connentTimer fire];
}

//发送实时数据请求
- (void)realTime{
    
    Byte array0[] ={0xA6,0xFF,0x04,0x54,0x72,0x75,0x65,0x90,0x56};
    
    
    NSData *personData0 = [[NSData alloc] initWithBytes:array0 length:9];
    
    [self writeCharacteristic:_peripheral characteristic:_Characteristic value:personData0];
    Byte array[] ={0xA6,0xD1,0x05,0x53,0x65,0x74,0x75,0x70,0xAE,0xFD};
    
    
    NSData *personData = [[NSData alloc] initWithBytes:array length:10];
    NSLog(@"按钮的perhpera:%@ 按钮中的特征:%@ 按钮中的特征值:%@",_peripheral,_Characteristic,_Characteristic.value);
    [self writeCharacteristic:_peripheral characteristic:_Characteristic value:personData];
}
- (void)centralManagerDidUpdateState:(CBCentralManager *)central{

    switch (central.state) {
        case CBManagerStateUnknown:
            NSLog(@"CBCentralManagerStateUnknown");
            break;
        case CBManagerStateResetting:
            NSLog(@"CBCentralManagerStateResetting");
            break;
            
        case CBManagerStateUnsupported:
            NSLog(@"CBCentralManagerStateUnsupported");
            break;
        case CBManagerStateUnauthorized:
            NSLog(@"CBCentralManagerStateUnauthrized");
            break;
        case CBManagerStatePoweredOff:
            NSLog(@"CBCentralManagerStatePoweredOff");
            NSLog(@"蓝牙未开启");
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
            [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
            [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:71/255.0 green:71/255.0 blue:71/255.0 alpha:0.8888888]];
            [SVProgressHUD setMinimumDismissTimeInterval:2.0];
            [SVProgressHUD setErrorImage:nil];
            [SVProgressHUD showErrorWithStatus:@"蓝牙未开启"];
            break;
        case CBManagerStatePoweredOn:
            NSLog(@"蓝牙已开启");
            _connect.text = @"正在连接中...";
            
            _state.image = [UIImage imageNamed:@"连接"];
            // [self.centralManager scanForPeripheralsWithServices:nil options:nil];

            [self.centralManager scanForPeripheralsWithServices:         @[[CBUUID UUIDWithString:@"FFF0"]] options:nil];
            //[self.centralManager stopScan];//停止扫描
            //当蓝牙处于打开状态,才开始执行扫描操作
            break;
        default:
            NSLog(@"蓝牙未工作在正常状态");
            break;
    }

}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI{
    NSLog(@"当扫描到设备:%@",peripheral.name);
//    [_arrBlue addObject:peripheral];
//    if ([peripheral.name hasPrefix:@"ST"]) {
//        //连接设备
//        _connect.text = @"扫描到设备";
//        [central connectPeripheral:peripheral options:nil];
//    }
        NSLog(@"外设的名称 == %@,外设 == %@ 信号强度 == %@",peripheral.name,peripheral,RSSI);
}
- (void)connectPeripheral:(CBPeripheral *)peripheral {

    [self.centralManager connectPeripheral:peripheral options:nil];// 连接外设 传入你搜索到的目标外设对象

    self.peripheral = peripheral;


    peripheral.delegate = self;//设置外设的代理 }

}
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral

{
    NSLog(@"didConnectPeripheral:%@",peripheral.name);
    NSLog(@">>>连接到名称为（%@）的设备-成功",peripheral.name);
    _connect.text = @"连接成功";
    _again.hidden = YES;
    _state.image = [UIImage imageNamed:@"成功"];
    [self.centralManager stopScan]; //连接成功后停止扫描

    [peripheral setDelegate:self];//设置代理

    [peripheral discoverServices:nil];

    //连接成功调用此方法来发现服务 }
    [self discoverService];

}
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral* )peripheral error:(NSError *)error {

    NSLog(@">>>连接到名称为（%@）的设备-失败,原因:%@",[peripheral name],[error localizedDescription]);
    _connect.text = @"连接失败";
    _state.image = [UIImage imageNamed:@"失败"];
}

- (void)discoverService {

    [_peripheral discoverServices:@[[CBUUID UUIDWithString:@"FFF0"]]];

}
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    //  NSLog(@">>>扫描到服务：%@",peripheral.services);
    if (error)
    {
        NSLog(@">>>Discovered services for %@ with error: %@", peripheral.name, [error localizedDescription]);
        return;
    }

    for (CBService *service in peripheral.services) {
        NSLog(@"service:%@",service.UUID);

        [peripheral discoverCharacteristics:nil forService:service];

    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error

{
    _peripheral = peripheral;
    if (error)
    {
        NSLog(@"error Discovered characteristics for %@ with error: %@", service.UUID, [error localizedDescription]);
        return;
    }
    _selfCharacteristics = service.characteristics;
    for (CBCharacteristic *characteristic in service.characteristics)
    {
        NSLog(@"service:%@ 的 Characteristic: %@",service.UUID,characteristic.UUID);
        if ([characteristic.UUID.UUIDString isEqualToString:@"FFF1"]) {

            _Characteristic = characteristic;
            [self startSend];
        }
        if ([characteristic.UUID.UUIDString isEqualToString:@"FFF4"]) {
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];

        }

        [peripheral setNotifyValue:YES forCharacteristic:characteristic];
    }



}
//CRC-16算法
uint16_t gan_crc16(const uint8_t *data, uint16_t size)
{
    uint16_t out = 0;
    int bits_read = 0, bit_flag;

    /* Sanity check: */
    if(data == NULL)
        return 0;

    while(size > 0)
    {
        bit_flag = out >> 15;

        /* Get next bit: */
        out <<= 1;
        out |= (*data >> bits_read) & 1; // item a) work from the least significant bits

        /* Increment bit counter: */
        bits_read++;
        if(bits_read > 7)
        {
            bits_read = 0;
            data++;
            size--;
        }

        /* Cycle check: */
        if(bit_flag)
            out ^= crc16;

    }

    // item b) "push out" the last 16 bits
    int i;
    for (i = 0; i < 16; ++i) {
        bit_flag = out >> 15;
        out <<= 1;
        if(bit_flag)
            out ^= crc16;
    }

    // item c) reverse the bits
    uint16_t crc = 0;
    i = 0x8000;
    int j = 0x0001;
    for (; i != 0; i >>=1, j <<= 1) {
        if (i & out) crc |= j;
    }

    return crc;
}



//获取的charateristic的值
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{


    NSLog(@"didUpdate里打印的   characteristic uuid:%@  value:%@",characteristic.UUID,characteristic.value);
        NSString *str = [self convertDataToHexStr:characteristic.value];
        if (str.length ==30) {
            NSLog(@"整条数据:%@",str);
            NSString *str1 = [str substringWithRange:NSMakeRange(6, 2)];
            NSString *str2 = [str substringWithRange:NSMakeRange(8, 2)];
            _humidity = [str2 stringByAppendingString:str1];
            NSString *shi =[NSString stringWithFormat:@"%ld",strtoul([_humidity UTF8String],0,16)];
            NSLog(@"str:%@str2:%@",str1,str2);
            NSLog(@"湿度:%@",shi);
            _value2.text = shi;
            NSInteger a = [shi integerValue];
            if (a  <15) {
                _triangle2.image = [UIImage imageNamed:@"三角1"];
            }else if (a>16){
                
                _triangle2.image = [UIImage imageNamed:@"三角上"];
            }else{
                _triangle2.image = nil;
            }
            
            
            
            
            
            NSString *str3 = [str substringWithRange:NSMakeRange(10, 2)];
            NSString *str4 = [str substringWithRange:NSMakeRange(12, 2)];
            _temperature = [str4 stringByAppendingString:str3];
            NSMutableString *wen = [NSMutableString stringWithFormat:@"%ld",strtoul([_temperature UTF8String],0,16)];
            NSLog(@"str3:%@str4:%@",str3,str4);
            [wen insertString:@"." atIndex:2];
            NSLog(@"温度:%@",wen);
            _value1.text = wen;
            float b = [wen floatValue];
            if (b  <5) {
                _triangle.image = [UIImage imageNamed:@"三角1"];
            }else if (b>32){
                
                _triangle.image = [UIImage imageNamed:@"三角上"];
            }else{
                _triangle.image = nil;
            }

            
            
            
            NSString *str5 = [str substringWithRange:NSMakeRange(14, 2)];
             NSString *str6 = [str substringWithRange:NSMakeRange(16, 2)];
            NSString *str7 = [str substringWithRange:NSMakeRange(18, 2)];
            NSString *str8 = [str substringWithRange:NSMakeRange(20, 2)];
            
            _sun = [NSString stringWithFormat:@"%@%@%@%@",str8,str7,str6,str5];
                 NSMutableString *guang = [NSMutableString stringWithFormat:@"%ld",strtoul([_sun UTF8String],0,16)];
            _value3.text = guang;
            NSInteger c = [guang integerValue];
            if (c  <600) {
                _triangle3.image = [UIImage imageNamed:@"三角1"];
            }else if (c>18000){
                
                _triangle3.image = [UIImage imageNamed:@"三角上"];
            }else{
                _triangle3.image = nil;
            }

            
}
}
    /**
     十进制转换十六进制

     @param decimal 十进制数
     @return 十六进制数
     */
+ (NSString *)getHexByDecimal:(NSInteger)decimal {

        NSString *hex =@"";
        NSString *letter;
        NSInteger number;
        for (int i = 0; i<9; i++) {

            number = decimal % 16;
            decimal = decimal / 16;
            switch (number) {

                case 10:
                    letter =@"A"; break;
                case 11:
                    letter =@"B"; break;
                case 12:
                    letter =@"C"; break;
                case 13:
                    letter =@"D"; break;
                case 14:
                    letter =@"E"; break;
                case 15:
                    letter =@"F"; break;
                default:
                    letter = [NSString stringWithFormat:@"%ld", number];
            }
            hex = [letter stringByAppendingString:hex];
            if (decimal == 0) {

                break;
            }
        }
        return hex;
    }


    //搜索到Characteristic的Descriptors
    //获取到Descriptors的值

    //写数据
    -(void)writeCharacteristic:(CBPeripheral *)peripheral
characteristic:(CBCharacteristic *)characteristic
value:(NSData *)value{
        [peripheral writeValue:value forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];

    NSLog(@"写入的value:%@",value);


}
    - (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic  error:(NSError *)error {

        if (error) {

            NSLog(@"Error writing characteristic value: %@",

                  [error localizedDescription]);

            return;

        }

        NSLog(@"写入%@成功",characteristic);
        // [self.peripheral readValueForCharacteristic:characteristic];

    }
//NSData转字符串
- (NSString *)convertDataToHexStr:(NSData *)data {
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];

    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];

    return string;
}
//字符串转Data
-(NSData*)stringToByte:(NSString*)string
{
    NSString *hexString=[[string uppercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([hexString length]%2!=0) {
        return nil;
    }
    Byte tempbyt[1]={0};
    NSMutableData* bytes=[NSMutableData data];
    for(int i=0;i<[hexString length];i++)
    {
        unichar hex_char1 = [hexString characterAtIndex:i]; ////两位16进制数中的第一位(高位*16)
        int int_ch1;
        if(hex_char1 >= '0' && hex_char1 <='9')
            int_ch1 = (hex_char1-48)*16;   //// 0 的Ascll - 48
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch1 = (hex_char1-55)*16; //// A 的Ascll - 65
        else
            return nil;
        i++;

        unichar hex_char2 = [hexString characterAtIndex:i]; ///两位16进制数中的第二位(低位)
        int int_ch2;
        if(hex_char2 >= '0' && hex_char2 <='9')
            int_ch2 = (hex_char2-48); //// 0 的Ascll - 48
        else if(hex_char2 >= 'A' && hex_char2 <='F')
            int_ch2 = hex_char2-55; //// A 的Ascll - 65
        else
            return nil;

        tempbyt[0] = int_ch1+int_ch2;  ///将转化后的数放入Byte数组里
        [bytes appendBytes:tempbyt length:1];
    }
    return bytes;
}
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    //设备断开连接
    _connect.text = @"断开连接";
    _again.hidden = NO;
    _state.image = [UIImage imageNamed:@"失败"];
    NSLog(@"%s, line = %d, %@=断开连接", __FUNCTION__, __LINE__, peripheral.name);
    Byte array0[] ={0xA6,0xFF,0x04,0x54,0x72,0x75,0x65,0x90,0x56};


    NSData *personData0 = [[NSData alloc] initWithBytes:array0 length:9];

    [self writeCharacteristic:_peripheral characteristic:_Characteristic value:personData0];[_centralManager cancelPeripheralConnection:peripheral];

}
@end
