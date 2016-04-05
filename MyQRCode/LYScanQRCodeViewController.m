//
//  LYScanQRCodeViewController.m
//  MyQRCode
//
//  Created by Leo on 16/3/31.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "LYScanQRCodeViewController.h"
#import "LYMacro.h"

@interface LYScanQRCodeViewController () <UIAlertViewDelegate>

@end

@implementation LYScanQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)showScanedMessage:(NSString *)message {
    SHOWALERTWithDelegate(@"二维码信息：", message, self, @"取消", @"确定");
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        if (self.restartCameraBlock) {
            self.restartCameraBlock();
        }
    }
}

@end
