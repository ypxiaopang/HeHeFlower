//
//  RealTimeViewController.m
//  Flower
//
//  Created by Apple on 2018/3/1.
//  Copyright © 2018年 Apple. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "RealTimeViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#define CRC16 0x8005
@interface RealTimeViewController ()<CBPeripheralDelegate,CBCentralManagerDelegate>

@property(nonatomic, strong)UILabel *label1;
@property(nonatomic, strong)UILabel *label2;
@property(nonatomic, strong)UILabel *label3;
@property(nonatomic, strong)UILabel *label4;
@property(nonatomic, strong)UILabel *label5;
@property(nonatomic, strong)UILabel *label6;
@property(nonatomic, strong)UILabel *label7;



@property(nonatomic, strong)CBCentralManager *centralManager;
@property(nonatomic, strong)CBPeripheral *peripheral;
@property(nonatomic, strong)CBCharacteristic *Characteristic1;
@property(nonatomic, strong)CBCharacteristic *Characteristic2;
@property(nonatomic, strong)CBCharacteristic *CharacteristicTX;
@property(nonatomic, strong)CBCharacteristic *CharacteristicRX;
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

@implementation RealTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createLabel];
    [self createButton];
    _arrBlue = [NSMutableArray array];
    self.view.backgroundColor = [UIColor redColor];
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    [_peripheral setDelegate:self];
    _length = 0;
    
}




//获取当前时间戳
+(NSString *)getNowTimeTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];
    //现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    
    return timeSp;
    
}



- (void)createButton{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(50, 50, 100, 100);
    button.backgroundColor = [UIColor blueColor];
    [button addTarget:self action:@selector(startSend) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"发送实时数据请求" forState: UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:10];
    [self.view addSubview:button];
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(150, 50, 100, 100);
    button1.backgroundColor = [UIColor greenColor];
    [button1 setTitle:@"发送失败信息" forState: UIControlStateNormal];
    [button1 addTarget:self action:@selector(duankai1) forControlEvents:UIControlEventTouchUpInside];
    button1.titleLabel.font = [UIFont systemFontOfSize:10];
    [self.view addSubview:button1];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(250, 50, 100, 100);
    button2.backgroundColor = [UIColor orangeColor];
    [button2 setTitle:@"发送成功信息" forState: UIControlStateNormal];
    [button2 addTarget:self action:@selector(duankai2) forControlEvents:UIControlEventTouchUpInside];
    button2.titleLabel.font = [UIFont systemFontOfSize:10];
    [self.view addSubview:button2];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(50, 200, 100, 100);
    button3.backgroundColor = [UIColor blueColor];
    [button3 addTarget:self action:@selector(duankai3) forControlEvents:UIControlEventTouchUpInside];
    [button3 setTitle:@"发送实时时间信息" forState: UIControlStateNormal];
    button3.titleLabel.font = [UIFont systemFontOfSize:10];
    [self.view addSubview:button3];
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    button4.frame = CGRectMake(150, 200, 100, 100);
    button4.backgroundColor = [UIColor greenColor];
    [button4 setTitle:@"发送历史数据请求" forState: UIControlStateNormal];
    [button4 addTarget:self action:@selector(duankai4) forControlEvents:UIControlEventTouchUpInside];
    button4.titleLabel.font = [UIFont systemFontOfSize:10];
    [self.view addSubview:button4];
    UIButton *button5 = [UIButton buttonWithType:UIButtonTypeCustom];
    button5.frame = CGRectMake(250, 200, 100, 100);
    button5.backgroundColor = [UIColor orangeColor];
    [button5 setTitle:@"断开连接" forState: UIControlStateNormal];
    [button5 addTarget:self action:@selector(duankai5) forControlEvents:UIControlEventTouchUpInside];
    button5.titleLabel.font = [UIFont systemFontOfSize:10];
    [self.view addSubview:button5];
    
    
    
}

- (void)createLabel{
    
    _label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 400, MSWIDTH/2, 50)];
    _label1.backgroundColor = [UIColor greenColor];
    _label1.textColor = [UIColor blackColor];
    _label1.font = [UIFont systemFontOfSize:14 weight:2];
    _label1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_label1];
    
    _label2 = [[UILabel alloc]initWithFrame:CGRectMake(MSWIDTH/2, 400, MSWIDTH/2, 50)];
    _label2.textColor = [UIColor blackColor];
    _label2.backgroundColor = [UIColor blueColor];
    _label2.font = [UIFont systemFontOfSize:14 weight:2];
    _label2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_label2];
    
    _label3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 250+MSWIDTH/2, MSWIDTH/2, 50)];
    _label3.textColor = [UIColor blackColor];
    _label3.backgroundColor = [UIColor orangeColor];
    _label3.font = [UIFont systemFontOfSize:14 weight:2];
    _label3.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_label3];
    
    _label4 = [[UILabel alloc]initWithFrame:CGRectMake(MSWIDTH/2, 250 +MSWIDTH/2, MSWIDTH/2, 50)];
    _label4.backgroundColor = [UIColor yellowColor];
    _label4.textColor = [UIColor blackColor];
    _label4.textAlignment = NSTextAlignmentCenter;
    _label4.font = [UIFont systemFontOfSize:14 weight:2];
    [self.view addSubview:_label4];
    _label5 = [[UILabel alloc]initWithFrame:CGRectMake(0, 300 +MSWIDTH/2, MSWIDTH/2, 50)];
    _label5.backgroundColor = [UIColor yellowColor];
    _label5.textColor = [UIColor blackColor];
    _label5.textAlignment = NSTextAlignmentCenter;
    _label5.font = [UIFont systemFontOfSize:14 weight:2];
    [self.view addSubview:_label5];
    _label6 = [[UILabel alloc]initWithFrame:CGRectMake(MSWIDTH/2, 300+MSWIDTH/2, MSWIDTH/2, 50)];
    _label6.textColor = [UIColor blackColor];
    _label6.backgroundColor = [UIColor orangeColor];
    _label6.font = [UIFont systemFontOfSize:14 weight:2];
    _label6.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_label6];
    _label7 = [[UILabel alloc]initWithFrame:CGRectMake(0, 350+MSWIDTH/2, MSWIDTH, 50)];
    _label7.textColor = [UIColor blackColor];
    _label7.backgroundColor = [UIColor grayColor];
    _label7.font = [UIFont systemFontOfSize:14 weight:2];
    _label7.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:_label7];
}


- (void)duankai{
    //    for (CBCharacteristic *characteristic in _selfCharacteristics){
    //        if ([characteristic.UUID.UUIDString isEqualToString:@"FFF4"]) {
    //            [ _peripheral setNotifyValue:YES forCharacteristic:characteristic];
    //
    //        }
    //    }
    _requestType = 1;
    Byte array0[] ={0xA6,0xFF,0x04,0x54,0x72,0x75,0x65,0x90,0x56};
    
    
    NSData *personData0 = [[NSData alloc] initWithBytes:array0 length:9];
    
    [self writeCharacteristic:_peripheral characteristic:_Characteristic value:personData0];
    Byte array[] ={0xA6,0xD1,0x05,0x53,0x65,0x74,0x75,0x70,0xAE,0xFD};
    
    
    NSData *personData = [[NSData alloc] initWithBytes:array length:10];
    NSLog(@"按钮的perhpera:%@ 按钮中的特征:%@ 按钮中的特征值:%@",_peripheral,_Characteristic,_Characteristic.value);
    [self writeCharacteristic:_peripheral characteristic:_Characteristic value:personData];
}
- (void)duankai1{
    
    Byte array[] ={0xA6,0xFF,0x04,0x46,0x61,0x69,0x6C,0xEB,0x6A};
    NSLog(@"按钮的perhpera:%@ 按钮中的特征:%@ 按钮中的特征值:%@",_peripheral,_Characteristic,_Characteristic.value);
    
    NSData *personData = [[NSData alloc] initWithBytes:array length:9];
    
    [self writeCharacteristic:_peripheral characteristic:_Characteristic value:personData];
}
- (void)duankai2{
    Byte array[] ={0xA6,0xFF,0x04,0x54,0x72,0x75,0x65,0x90,0x56};
    
    
    NSData *personData = [[NSData alloc] initWithBytes:array length:9];
    
    [self writeCharacteristic:_peripheral characteristic:_Characteristic value:personData];
    
    
}

- (void)startSend{
    
    self.connentTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(duankai) userInfo:nil repeats:YES];
    [self.connentTimer fire];
}
- (void)duankai3{
    
    NSString *time=   [[self class] getNowTimeTimestamp];
    NSLog(@"time:%@",time);
    NSString *time16 = [[self class] getHexByDecimal:[time integerValue]];
    NSData *data = [self stringToByte:time16];
    Byte *byte =  (Byte *)[data bytes];
    NSLog(@"byte:%s",byte);
    NSString *a =  [[self class] getHexByDecimal:gen_crc16(byte, 4)];
    NSLog(@"校验结果:%@",a);
    NSString *All = [NSString stringWithFormat:@"A6C104%@%@",time16,a];
    NSLog(@"All:%@",All);
    NSData *finalData = [self stringToByte:All];
    [self writeCharacteristic:_peripheral characteristic:_Characteristic value:finalData];
    
}


- (void)duankai4{
    _requestType = 2;
    
    
    Byte array[] ={0xA6,0xE1,0x04,0x52,0x65,0x61,0x6C,0x1A,0x29};
    
    
    NSData *personData = [[NSData alloc] initWithBytes:array length:9];
    
    [self writeCharacteristic:_peripheral characteristic:_Characteristic value:personData];
    
    
    
    
}

- (void)erbaisi{
    
    
    self.connentTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(xunhuan) userInfo:nil repeats:YES];
    [self.connentTimer fire];
    
    
    
    
    
    
}

- (void)xunhuan{
    
    
    //    if (_length <240) {
    //        _length = _length + 1;
    //
    //        NSString *str  = [NSString stringWithFormat:@"%ld",_length/100];
    //        _label7.text = [NSString stringWithFormat:@"%@",str];
    //
    //        Byte array[] ={0xA6,0xFF,0x04,0x54,0x72,0x75,0x65,0x90,0x56};
    //
    //
    //        NSData *personData = [[NSData alloc] initWithBytes:array length:9];
    //
    //        [self writeCharacteristic:_peripheral characteristic:_Characteristic value:personData];
    //    }
    
    
    
    NSLog(@"_length: %ld",_length);
    
    
}


- (void)duankai5{
    [_connentTimer invalidate];
    _connentTimer = nil;
    [_centralManager cancelPeripheralConnection:_peripheral];
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
            break;
        case CBManagerStatePoweredOn:
            NSLog(@"蓝牙已开启");
            _label3.text = @"蓝牙已开启";
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
    [_arrBlue addObject:peripheral];
    if ([peripheral.name hasPrefix:@"ST"]) {
        //连接设备
        _label4.text = @"扫描到设备ST-BLE01";
        [central connectPeripheral:peripheral options:nil];
    }
    
    
    
    //每个蓝牙设备有自己唯一的标识符，根据标识符确认自己要连接的设备
    //    if ([peripheral.identifier isEqual:self.peripheral.identifier])
    //    {
    //        self.peripheral = peripheral;
    //        //数据连接定时器
    //            self.connentTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(connectPeripheral:) userInfo:nil repeats:YES];
    //            [self.connentTimer fire];
    //    }
}


- (void)connectPeripheral:(CBPeripheral *)peripheral {
    
    [self.centralManager connectPeripheral:peripheral options:nil];// 连接外设 传入你搜索到的目标外设对象
    
    self.peripheral = peripheral;
    
    
    peripheral.delegate = self;//设置外设的代理 }
    
}
//- (void)disConnectPeripheral:(CBPeripheral *)peripheral{
//
//    [_centralManager cancelPeripheralConnection:peripheral];//断开连接
//
//}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral

{
    NSLog(@"didConnectPeripheral:%@",peripheral.name);
    NSLog(@">>>连接到名称为（%@）的设备-成功",peripheral.name);
    _label5.text = @"连接到ST-BLE01成功";
    [self.centralManager stopScan]; //连接成功后停止扫描
    
    [peripheral setDelegate:self];//设置代理
    
    [peripheral discoverServices:nil];
    
    //连接成功调用此方法来发现服务 }
    [self discoverService];
    
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral* )peripheral error:(NSError *)error {
    
    NSLog(@">>>连接到名称为（%@）的设备-失败,原因:%@",[peripheral name],[error localizedDescription]);
    _label5.text = @"连接失败";
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
        _label6.text = @"发现设备特征";
        if ([characteristic.UUID.UUIDString isEqualToString:@"FFF1"]) {
            
            _Characteristic = characteristic;
            
        }
        if ([characteristic.UUID.UUIDString isEqualToString:@"FFF4"]) {
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
            
        }
        
        [peripheral setNotifyValue:YES forCharacteristic:characteristic];
    }
    
    
    
}



//CRC-16算法
uint16_t gen_crc16(const uint8_t *data, uint16_t size)
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
            out ^= CRC16;
        
    }
    
    // item b) "push out" the last 16 bits
    int i;
    for (i = 0; i < 16; ++i) {
        bit_flag = out >> 15;
        out <<= 1;
        if(bit_flag)
            out ^= CRC16;
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
    if (_requestType == 2) {
        if (_length <243) {
            NSLog(@"_length: %.0f",_length);
            _length = _length + 1;
            
            NSString *str  = [NSString stringWithFormat:@"%.0f",_length/243*100];
            _label7.text = [NSString stringWithFormat:@"正在同步历史数据%@%%",str];
            NSString *date = [self convertDataToHexStr:characteristic.value];
            if (date.length == 18&&[date containsString:@"a6a104"]) {
                NSString *str = [self convertDataToHexStr:characteristic.value];
                NSString *str1 = [str substringWithRange:NSMakeRange(6, 2)];
                NSString *str2 = [str substringWithRange:NSMakeRange(8, 2)];
                NSString *str3 = [str substringWithRange:NSMakeRange(10, 2)];
                NSString *str4 = [str substringWithRange:NSMakeRange(12, 2)];
                
                NSString *shi1 =[NSString stringWithFormat:@"%ld",strtoul([str1 UTF8String],0,16)];
                NSString *shi2 =[NSString stringWithFormat:@"%ld",strtoul([str2 UTF8String],0,16)];
                NSString *shi3 =[NSString stringWithFormat:@"%ld",strtoul([str3 UTF8String],0,16)];
                NSString *shi4 =[NSString stringWithFormat:@"%ld",strtoul([str4 UTF8String],0,16)];
                NSLog(@"历史数据末次存储时间:%@月%@时%@分%@秒",shi1,shi2,shi3,shi4);
            }
//            if (date.length == 26&&[date containsString:@"a6ff04547275655690"]) {
//                NSString *chuo = [date substringWithRange:NSMakeRange(18, 8)];
//                // NSInteger shiliu = [chuo integerValue];
//                NSString *shi =[NSString stringWithFormat:@"%ld",strtoul([chuo UTF8String],0,16)];
//                NSTimeInterval interval    =[shi doubleValue] ;
//                NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
//
//                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//                [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//                NSString *dateString       = [formatter stringFromDate: date];
//                NSLog(@"时间戳:%@",shi);
//                NSLog(@"时间戳对应的时间是:%@",dateString);
//            }
            
            Byte array[] ={0xA6,0xFF,0x04,0x54,0x72,0x75,0x65,0x90,0x56};
            
            
            NSData *personData = [[NSData alloc] initWithBytes:array length:9];
            
            [self writeCharacteristic:_peripheral characteristic:_Characteristic value:personData];
        }else{
            
        }
        
    }else{
        NSString *str = [self convertDataToHexStr:characteristic.value];
        if (str.length ==20) {
            NSLog(@"整条数据:%@",str);
            NSString *str1 = [str substringWithRange:NSMakeRange(0, 2)];
            NSString *str2 = [str substringWithRange:NSMakeRange(2, 2)];
            _humidity = [str2 stringByAppendingString:str1];
            NSString *shi =[NSString stringWithFormat:@"%ld",strtoul([_humidity UTF8String],0,16)];
            
            NSLog(@"str:%@str2:%@",str1,str2);
            NSLog(@"湿度:%@",shi);
            
            NSString *str3 = [str substringWithRange:NSMakeRange(4, 2)];
            NSString *str4 = [str substringWithRange:NSMakeRange(6, 2)];
            _temperature = [str4 stringByAppendingString:str3];
            NSMutableString *wen = [NSMutableString stringWithFormat:@"%ld",strtoul([_temperature UTF8String],0,16)];
            NSLog(@"str3:%@str4:%@",str3,str4);
            [wen insertString:@"." atIndex:2];
            NSLog(@"温度:%@",wen);
            _label1.text = [NSString stringWithFormat:@"湿度:%@",shi];
            _label2.text = [NSString stringWithFormat:@"温度:%@",wen];
            
            
        }else{
            
            
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
    
    
    
    // NSLog(@"888:%lu", (unsigned long)characteristic.properties);
    
    //        NSLog(@"写入数据了");
    NSLog(@"写入时的charuuid:%@",characteristic.UUID.UUIDString);
    NSLog(@"第二次写入的charuuid:%@",_Characteristic.UUID.UUIDString);
    [peripheral writeValue:value forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
    
    NSLog(@"写入的value:%@",value);
    
    
}
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic  error:(NSError *)error {
    
    if (error) {
        
        NSLog(@"Error writing characteristic value: %@",
              
              [error localizedDescription]);
        
        return;
        
    }
    
    //NSLog(@"写入%@成功",characteristic);
    // [self.peripheral readValueForCharacteristic:characteristic];
    
}

////设置通知
//-(void)notifyCharacteristic:(CBPeripheral *)peripheral
//             characteristic:(CBCharacteristic *)characteristic{
//    //设置通知，数据通知会进入：didUpdateValueForCharacteristic方法
//    [peripheral setNotifyValue:YES forCharacteristic:characteristic];
//
//}
//中心读取外设实时数据

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (error) {
        NSLog(@"Error changing notification state: %@", error.localizedDescription);
    }else{
        
        
        
        NSString *result = [self convertDataToHexStr:characteristic.value];
        Byte *byte =  (Byte *)[characteristic.value bytes];
        
        NSLog(@"通知里打印的   characteristic uuid:%@  value:%@",characteristic.UUID,characteristic.value);
        
        
        
    }
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
//取消通知
-(void)cancelNotifyCharacteristic:(CBPeripheral *)peripheral
                   characteristic:(CBCharacteristic *)characteristic{
    
    [peripheral setNotifyValue:NO forCharacteristic:characteristic];
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

//停止扫描并断开连接
//-(void)disconnectPeripheral:(CBCentralManager *)centralManager
//                 peripheral:(CBPeripheral *)peripheral{
//    //停止扫描
//    [centralManager stopScan];
//    //断开连接
//    [centralManager cancelPeripheralConnection:peripheral];
//}


- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    //设备断开连接
    NSLog(@"%s, line = %d, %@=断开连接", __FUNCTION__, __LINE__, peripheral.name);
    Byte array0[] ={0xA6,0xFF,0x04,0x54,0x72,0x75,0x65,0x90,0x56};
    
    
    NSData *personData0 = [[NSData alloc] initWithBytes:array0 length:9];
    
    [self writeCharacteristic:_peripheral characteristic:_Characteristic value:personData0];[_centralManager cancelPeripheralConnection:peripheral];
    
}







@end
