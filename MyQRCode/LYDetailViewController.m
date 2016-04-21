//
//  LYDetailViewController.m
//  MyQRCode
//
//  Created by Leo on 16/3/29.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "LYDetailViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "LYScanQRCodeViewController.h"
#import "LYCreatQRCodeViewController.h"
#import "LYMacro.h"

@interface LYDetailViewController ()<AVCaptureMetadataOutputObjectsDelegate> {
    BOOL creatQRCodeBtnSelected;
    BOOL scanQRCodeBtnSelected;
}

@property (weak, nonatomic) IBOutlet UIButton *scanQRCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *creatQRCodeBtn;
@property (nonatomic, strong) LYScanQRCodeViewController *scanQRCodeVC;
@property (nonatomic, strong) LYCreatQRCodeViewController *creatQRCodeVC;
@property (nonatomic, strong) AVCaptureDevice *device;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *preview;
@property (nonatomic, strong) AVCaptureDeviceInput *input;
@property (nonatomic, strong) AVCaptureMetadataOutput *output;

@end

@implementation LYDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.scanQRCodeVC = [[LYScanQRCodeViewController alloc] init];
    self.creatQRCodeVC = [[LYCreatQRCodeViewController alloc] init];
    [self addChildViewController:_scanQRCodeVC];
    [self addChildViewController:_creatQRCodeVC];
    [self.view addSubview:self.scanQRCodeVC.view];
    [self.view bringSubviewToFront:self.scanQRCodeBtn];
    [self.view bringSubviewToFront:self.creatQRCodeBtn];
    scanQRCodeBtnSelected = YES;
//    [self setupCamera];
    WS(ws);
    self.scanQRCodeVC.restartCameraBlock = ^ {
        [ws.session startRunning];
    };
}

- (IBAction)handleScanQRCodeBtnAction:(UIButton *)sender {
    if (!scanQRCodeBtnSelected) {
        scanQRCodeBtnSelected = YES;
        creatQRCodeBtnSelected = NO;
        [self transitionFromViewController:self.creatQRCodeVC toViewController:self.scanQRCodeVC duration:0.0f options:UIViewAnimationOptionTransitionNone animations:nil completion:nil];
        [self.view bringSubviewToFront:self.scanQRCodeBtn];
        [self.view bringSubviewToFront:self.creatQRCodeBtn];
        self.preview.hidden = NO;
        [self.session startRunning];
    }
}

- (IBAction)handleCreatQRCodeBtnAction:(UIButton *)sender {
    if (!creatQRCodeBtnSelected) {
        creatQRCodeBtnSelected = YES;
        scanQRCodeBtnSelected = NO;
        [self transitionFromViewController:self.scanQRCodeVC toViewController:self.creatQRCodeVC duration:0.0f options:UIViewAnimationOptionTransitionNone animations:nil completion:nil];
        [self.view bringSubviewToFront:self.scanQRCodeBtn];
        [self.view bringSubviewToFront:self.creatQRCodeBtn];
        self.view.backgroundColor = [UIColor whiteColor];
        self.preview.hidden = YES;
        [self.session stopRunning];
    }
}

- (void)setupCamera {
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    self.session = [[AVCaptureSession alloc] init];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"请打开相机" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    self.output = [[AVCaptureMetadataOutput alloc] init];
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    if ([self.session canAddOutput:self.output]) {
        [self.session addOutput:self.output];
    }
    self.output.metadataObjectTypes = @[AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeUPCECode,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode93Code,AVMetadataObjectTypePDF417Code,AVMetadataObjectTypeQRCode,AVMetadataObjectTypeAztecCode,AVMetadataObjectTypeInterleaved2of5Code,AVMetadataObjectTypeITF14Code,AVMetadataObjectTypeDataMatrixCode];
    self.preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.preview.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
    [self.view.layer insertSublayer:self.preview atIndex:0];
    [self.session startRunning];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (metadataObjects && metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects firstObject];
        if ([metadataObj.type isEqualToString:AVMetadataObjectTypeQRCode]) {
            [self.session stopRunning];
            [self.scanQRCodeVC showScanedMessage:metadataObj.stringValue];
            NSLog(@"%@", metadataObj.stringValue);
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
