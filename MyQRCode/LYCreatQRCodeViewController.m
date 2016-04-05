//
//  LYCreatQRCodeViewController.m
//  MyQRCode
//
//  Created by Leo on 16/3/29.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "LYCreatQRCodeViewController.h"
#import "QRCodeGenerator.h"
#import "LYMacro.h"
#import <CoreImage/CoreImage.h>

@interface LYCreatQRCodeViewController ()

@property (strong, nonatomic) UITextField *messageTestField;
@property (strong, nonatomic) UIButton *creatBtn;
@property (strong, nonatomic) UIImageView *showQRCodeImgView;

@end

@implementation LYCreatQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapAction:)];
    [self.view addGestureRecognizer:tap];
    [self initCreateQRCode];
//    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    imgView.center = self.view.center;
//    imgView.image = [QRCodeGenerator qrImageForString:@"12321svdsafasfa" imageSize:imgView.bounds.size.width];
//    [self.view addSubview:imgView];
}

- (void)initCreateQRCode {
    self.messageTestField = [[[NSBundle mainBundle] loadNibNamed:@"LYTextFieldView" owner:nil options:nil] firstObject];
    self.messageTestField.frame = CGRectMake(40, 220, [UIScreen mainScreen].bounds.size.width - 120 - 40, 40);
    self.creatBtn = [[[NSBundle mainBundle] loadNibNamed:@"LYTextFieldView" owner:nil options:nil] objectAtIndex:1];
    self.creatBtn.frame = CGRectMake(CGRectGetMaxX(self.messageTestField.frame) + 20, CGRectGetMinY(self.messageTestField.frame), 70, 40);
    [self.creatBtn addTarget:self action:@selector(handleCreatBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.showQRCodeImgView = [[[NSBundle mainBundle] loadNibNamed:@"LYTextFieldView" owner:nil options:nil] lastObject];
    self.showQRCodeImgView.frame = CGRectMake(0, 0, 130, 130);
    self.showQRCodeImgView.center = CGPointMake(self.view.center.x, CGRectGetMaxY(self.messageTestField.frame) + 20 + 65);
    self.showQRCodeImgView.hidden = YES;
    [self.view addSubview:self.messageTestField];
    [self.view addSubview:self.creatBtn];
    [self.view addSubview:self.showQRCodeImgView];
  /*
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    imgView.center = self.view.center;
//    imgView.image = [QRCodeGenerator qrImageForString:@"12321svdsafasfa" imageSize:imgView.bounds.size.width];
    [self.view addSubview:imgView];
    imgView.image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:100.0];
   */
}

- (void)handleCreatBtnAction:(UIButton *)sender {
    [self.view endEditing:YES];
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    if (self.messageTestField.text) {
        NSData *data = [self.messageTestField.text dataUsingEncoding:NSUTF8StringEncoding];
        [filter setValue:data forKey:@"inputMessage"];
        CIImage *outputImage = [filter outputImage];
        self.showQRCodeImgView.image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:120];
        self.showQRCodeImgView.hidden = NO;
    } else {
        SHOWALERT(@"提示", @"请输入信息！");
    }
}

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    
    CGRect extent = CGRectIntegral(image.extent);
    
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 创建bitmap;
    
    size_t width = CGRectGetWidth(extent) * scale;
    
    size_t height = CGRectGetHeight(extent) * scale;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    
    CGContextScaleCTM(bitmapRef, scale, scale);
    
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 保存bitmap到图片
    
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    
    CGContextRelease(bitmapRef);
    
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
    
}

- (void)handleTapAction:(UIGestureRecognizer *)sender {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
