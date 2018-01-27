//
//  MainViewController.m
//  movieProject
//
//  Created by HH on 2017/12/17.
//  Copyright © 2017年 lqf. All rights reserved.
//

#import "MainViewController.h"
#import "MainTabbar.h"
#import "homeViewController.h"
#import "NAVprijectViewController.h"
#import "shouyeViewController.h"
#import "guanzhuViewController.h"
#import "myViewController.h"
#import "FriendTrendsViewController.h"
#import "FourViewController.h"

#import "tongzhiViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //获取全部tarbaritem
    UITabBarItem *item = [UITabBarItem appearance];
    
    
    //设置普通状态下的文字属性
    NSMutableDictionary *normalattrs = [NSMutableDictionary dictionary];
    normalattrs[NSForegroundColorAttributeName]=[UIColor grayColor];
    [item setTitleTextAttributes:normalattrs forState:UIControlStateNormal];
    
    //设置选中状态下的文字属性
    NSMutableDictionary *selectAttrs= [NSMutableDictionary dictionary];
    selectAttrs [NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [item setTitleTextAttributes:selectAttrs forState:UIControlStateSelected];

    
    [self setValue:[[MainTabbar alloc]init] forKey:@"tabBar"];

    // 设置底部工具栏的四个导航items控件
    [self setUponeChildViewConteoller:[[NAVprijectViewController alloc]initWithRootViewController:[[homeViewController alloc]init]] title:nil image:@"ic_tab_1_49x49_" selectedImage:@"ic_tab_1_selected_49x49_"];
    [self setUponeChildViewConteoller:[[NAVprijectViewController alloc]initWithRootViewController:[[guanzhuViewController alloc]init]] title:nil image:@"ic_tab_2_49x49_" selectedImage:@"ic_tab_2_selected_49x49_"];
    [self setUponeChildViewConteoller:[[NAVprijectViewController alloc]initWithRootViewController:[[FriendTrendsViewController alloc]init]] title:nil image:@"ic_tab_3_49x49_" selectedImage:@"ic_tab_3_selected_49x49_"];
    [self setUponeChildViewConteoller:[[NAVprijectViewController alloc]initWithRootViewController:[[FourViewController alloc]init]] title:nil image:@"ic_tab_4_49x49_" selectedImage:@"ic_tab_4_selected_49x49_"];
}





-(void)setUponeChildViewConteoller:(UIViewController *)vc title:(NSString*)title image:(NSString*)image selectedImage:(NSString*)selectImage
{
    vc.tabBarItem.title = title;
    
    if (image.length) {
        vc.tabBarItem.image = [UIImage imageNamed:image];
        vc.tabBarItem.selectedImage=[UIImage imageNamed:selectImage];
    }
    [self addChildViewController:vc];
}

@end

