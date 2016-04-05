//
//  LYScanQRCodeViewController.h
//  MyQRCode
//
//  Created by Leo on 16/3/31.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYScanQRCodeViewController : UIViewController

@property (nonatomic, copy) void (^restartCameraBlock)(void);

- (void)showScanedMessage:(NSString *)message;

@end
