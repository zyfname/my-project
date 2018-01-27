//
//  NAVprijectViewController.m
//  movieProject
//
//  Created by HH on 2017/12/17.
//  Copyright © 2017年 lqf. All rights reserved.
//

#import "NAVprijectViewController.h"

@interface NAVprijectViewController ()<UIGestureRecognizerDelegate>

@end

@implementation NAVprijectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
   
    //获取右滑识别手势，设置代理，退出当前控制器
    self.interactivePopGestureRecognizer.delegate =self;
}

//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated; // Uses a horizontal slide transition. Has no effect if the view controller is already in the stack.
//

//重写方法，拦截所有push进来的子控制器
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    
    viewController.navigationItem.rightBarButtonItem =[UIBarButtonItem itemWithImage:@"friendsRecommentIcon"  target:self heightImage:@"friendsRecommentIcon-click" action:@selector(abc)];
    
    if(self.childViewControllers.count>0){//self.childviewController.count是指当前导航控制器的子控制器数
        //如果viewController不是最早push进来的控制器
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"]  forState:UIControlStateHighlighted];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [ button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        //控件自适应图片大小
        [button sizeToFit];
        
        //设置按钮的内边距，放在[button sizeToFit]之后，调整控件与屏幕边缘的距离
        button.contentEdgeInsets=UIEdgeInsetsMake(0,-20, 0, 0);
        
        
        //添加返回方法
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:button];
        //隐藏底部工具条
        viewController.hidesBottomBarWhenPushed=YES;
    }
    
    
    //所有设置搞定在push控制器，必须放在后面
    [super pushViewController:viewController animated:animated];
    
    
}

/**
 手势识别器会调用这个方法来决定手势是否有效
 **/
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    
    
    //    return self.childViewControllers.count>1;
    
    //判断手势在哪个控制器使用
    if(self.childViewControllers.count==1){//导航控制器中只有一个子控制器，就是最开始作为导航控制器的根控制器对象
        return NO;
    }
    return YES;
}


//实现返回方法
-(void)back{
    [self popViewControllerAnimated:YES];
}

@end
