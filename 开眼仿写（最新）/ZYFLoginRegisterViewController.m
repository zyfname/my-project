//
//  ZYFTabBar.m
//  百思不得姐
//
//  Created by HH on 2017/10/1.
//  Copyright © 2017年 HH. All rights reserved.
//

#import "ZYFLoginRegisterViewController.h"
#import "UIView+ProjectUIView.h"
@interface ZYFLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMargin;
//@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@end

@implementation ZYFLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
// 设置光标颜色   self.phoneField.tintColor = [UIColor whiteColor];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

/**
 *  关闭当前界面
 */

- (IBAction)Close {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)LoginOrRegister:(UIButton *)sender {
    // 退出键盘
    [self.view endEditing:YES];
    
    // 设置约束 和 按钮状态
    if (self.leftMargin.constant) { // 目前显示的是注册界面, 点击按钮后要切换为登录界面
        self.leftMargin.constant = 0;
        sender.selected = NO;
    } else { // 目前显示的是登录界面, 点击按钮后要切换为注册界面
             self.leftMargin.constant = - self.view.zyf_width;
        sender.selected = YES;
    }
    
    // 动画
    [UIView animateWithDuration:0.25 animations:^{
        // 强制刷新 : 让最新设置的约束值马上应用到UI控件上
        // 会刷新到self.view内部的所有子控件
        [self.view layoutIfNeeded];
    }];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
