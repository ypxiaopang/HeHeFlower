//
//  ScanQRCodeViewController.m
//  Flower
//
//  Created by 张营营 on 2018/4/2.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "ScanQRCodeViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ScanQRCodeViewController ()

@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;

@end

@implementation ScanQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    _output = [[AVCaptureMetadataOutput alloc] init];
    id delegate = self;
    [_output setMetadataObjectsDelegate:delegate queue:dispatch_get_main_queue()];
    
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }

    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
    
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity =AVLayerVideoGravityResizeAspectFill;
    _preview.frame =self.view.layer.bounds;
    [self.view.layer insertSublayer:_preview atIndex:0];
    [_session startRunning];

    
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput  didOutputMetadataObjects:(NSArray *)metadataObjects  fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    if ([metadataObjects count] >0){
        //停止扫描
        [_session stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
}


@end
