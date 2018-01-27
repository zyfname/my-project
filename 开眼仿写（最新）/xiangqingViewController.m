//
//  xiangqingViewController.m
//  开眼放血（最新）
//
//  Created by a on 2018/1/5.
//  Copyright © 2018年 a. All rights reserved.
//

#import "xiangqingViewController.h"
#import "CLPlayerView.h"
#import "UIView+CLSetRect.h"

@interface xiangqingViewController ()<UITableViewDelegate,UITableViewDataSource>
/**CLplayer*/
@property (nonatomic,weak) CLPlayerView *playerView;@end

@implementation xiangqingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    
    tableview.backgroundColor = [UIColor purpleColor];
    tableview.delegate=self;
    tableview.dataSource=self;
    [self.view addSubview:tableview];
    
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [_playerView destroyPlayer];
}
#pragma mark -- 需要设置全局支持旋转方向，然后重写下面三个方法可以让当前页面支持多个方向
// 是否支持自动转屏
- (BOOL)shouldAutorotate {
    return YES;
}
// 支持哪些屏幕方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}
// 默认的屏幕方向（当前ViewController必须是通过模态出来的UIViewController（模态带导航的无效）方式展现出来的，才会调用这个方法）
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
   self.playerView = [[CLPlayerView alloc] initWithFrame:CGRectMake(0, 90, self.view.CLwidth, 250)];
//    _playerView = playerView;
    [self.view addSubview:_playerView];
    //    //当前控制器是否支持旋转，当前页面支持旋转的时候需要设置，告知播放器
    _playerView.isLandscape = YES;
    //    //全屏是否隐藏状态栏，默认一直不隐藏
    _playerView.fullStatusBarHiddenType = FullStatusBarHiddenNever;
    //    //顶部工具条隐藏样式，默认不隐藏
    _playerView.topToolBarHiddenType = TopToolBarHiddenNever;
    //  全屏手势控制，默认Yes
    _playerView.fullGestureControl = NO;
    //    小屏手势控制，默认NO
    _playerView.smallGestureControl = YES;
    //视频地址
    _playerView.url = [NSURL URLWithString:self.playurl];
    //播放
    [_playerView playVideo];
    //返回按钮点击事件回调,小屏状态才会调用，全屏默认变为小屏
    [_playerView backButton:^(UIButton *button) {
        
        [self dismissViewControllerAnimated:YES completion:^{
          

        }];
    }];
    //播放完成回调
    [_playerView endPlay:^{
        NSLog(@"播放完成");
    }];

    return _playerView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellString = @"cellString";//cell的重用
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellString];
    }
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 300;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}


@end
