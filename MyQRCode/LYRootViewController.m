//
//  LYRootViewController.m
//  MyQRCode
//
//  Created by Leo on 16/3/29.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "LYRootViewController.h"
#import "LYDetailViewController.h"
#import "LYCreatQRCodeViewController.h"
#import "LYMacro.h"

@interface LYRootViewController ()

@property (weak, nonatomic) IBOutlet UITextField *accountTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end

@implementation LYRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapAction:)];
    [self.view addGestureRecognizer:tap];
}

- (IBAction)handleLoginButtonAction:(UIButton *)sender {
    if (self.accountTextField.text && self.passwordTextField.text) {
        if ([PERMANENT_GET_OBJECT(self.accountTextField.text) isEqualToString:self.passwordTextField.text]) {
            LYDetailViewController *detailVC = [[LYDetailViewController alloc] init];
            [self.navigationController pushViewController:detailVC animated:YES];
        } else {
            SHOWALERT(@"提示", @"密码错误，请重新输入！");
        }
    }
    [self.view endEditing:YES];
}

- (IBAction)handleRegisterButtonAction:(UIButton *)sender {
    if (self.accountTextField.text && self.passwordTextField.text) {
        PERMANENT_SET_OBJECT(self.passwordTextField.text, self.accountTextField.text);
        SHOWALERT(@"提示", @"恭喜你，注册成功！");
    }
    [self.view endEditing:YES];
}

- (void)handleTapAction:(UIGestureRecognizer *)sender {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
