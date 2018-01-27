//
//  XMGFriendTrendsViewController.m
//  3期-百思不得姐
//
//  Created by xiaomage on 15/9/1.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import "FriendTrendsViewController.h"
#import "ZYFLoginRegisterViewController.h"
//#import "RecommendFollowViewController.h"

@interface FriendTrendsViewController ()

@end

@implementation FriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = XMGCommonBgColor;
    
    self.navigationItem.title = @"我的关注";
    
    // 导航栏左边的内容
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon"  target:self heightImage:@"friendsRecommentIcon-click" action:@selector(abc)];
                                             
                                             
                                             
                                             
                                            
}
- (IBAction)Login:(id)sender {
    ZYFLoginRegisterViewController * login = [[ZYFLoginRegisterViewController alloc]init];
    [self presentViewController:login animated:login completion:nil];
}




@end
