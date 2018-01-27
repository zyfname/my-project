//
//  CLViewController5.m
//  CLPlayerDemo
//
//  Created by JmoVxia on 2017/8/2.
//  Copyright © 2017年 JmoVxia. All rights reserved.
//

#import "CLViewController5.h"
#import "CLPlayerView.h"
#import "UIView+CLSetRect.h"
#import "celltitleview.h"
#import "AFNetworking.h"
#import "chuangyimodeul.h"
#import "mycell.h"

@interface CLViewController5 ()<UITableViewDelegate,UITableViewDataSource>
/**CLplayer*/
@property (nonatomic,weak) CLPlayerView *playerView;
@property(nonatomic,strong)AFHTTPSessionManager *manager;
@property(nonatomic,strong)UITableView *tab;
@property (nonatomic, strong) NSMutableArray *ListArr;

@end

@implementation CLViewController5
-(AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        
    }
    return _manager;
}

-(NSMutableArray *)ListArr
{
    if (!_ListArr) {
        _ListArr = [NSMutableArray array];
        
    }
    return _ListArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
     UITableView *tab =[ [UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain ];
    tab.separatorStyle=UITableViewCellSelectionStyleNone;
    tab.delegate =self;
    tab.dataSource=self;
    [self.view addSubview:tab];
    self.playurl=self.model.playUrl;
    self.tab = tab;
    self.playerView = [[CLPlayerView alloc] initWithFrame:CGRectMake(0, 0, self.view.CLwidth, 250)];

     [self.tab registerNib:[UINib nibWithNibName:NSStringFromClass([mycell class]) bundle:nil] forCellReuseIdentifier:@"mycell"];
    
    [self getauthorInfo];
}


- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark-delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    return self.ListArr.count;
}



-(void)getauthorInfo{
    
    
    
    [self.manager GET:@"http://baobab.wandoujia.com/api/v3/ranklist?_s=70fe21a9017cd00bd7390c82ca130cd3&f=iphone&net=wifi&p_product=EYEPETIZER_IOS&strategy=weekly&u=8141e05d14a4cabf8464f21683ad382c9df8d55e&v=2.7.0&vc=1305" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *itemListDict = [responseObject objectForKey:@"itemList"];
        
        for (NSDictionary *dict in itemListDict) {
            NSDictionary *dataDict = dict[@"data"];
            
            chuangyimodeul *model = [[chuangyimodeul alloc]init];
            model.coverForFeed = [NSString stringWithFormat:@"%@",dataDict[@"cover"][@"detail"]];
            model.title = [NSString stringWithFormat:@"%@",dataDict[@"title"]];
            model.category = [NSString stringWithFormat:@"%@",dataDict[@"category"]];
            model.miaoshu = [NSString stringWithFormat:@"%@",dataDict[@"duration"]];
            model.playUrl = [NSString stringWithFormat:@"%@",dataDict[@"playUrl"]];
//            model.icon = [NSString stringWithFormat:@"%@",dataDict[@"author"][@"icon"]];

            [_ListArr addObject:model];
        }
        
        NSLog(@"##################");
        [self.tab reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
 }


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * view = [[UIView alloc]init];

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
        [self.playerView destroyPlayer];
//        [self popoverPresentationController];
       [self dismissViewControllerAnimated:YES completion:^{
        
       }];
    }];
    //播放完成回调
    [_playerView endPlay:^{
        NSLog(@"播放完成");
    }];
    [view addSubview:_playerView];
    
    
    celltitleview * ct = [[celltitleview alloc]initWithFrame:CGRectMake(0, 250, self.view.bounds.size.width, 55)];

     ct.model =self.model;
 
    [view addSubview:ct];

    return view;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 310;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    mycell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell"];
    cell.backgroundColor = [UIColor colorWithRed:50 green:50 blue:50 alpha:1];
    cell.model=self.ListArr[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    chuangyimodeul *model =  self.ListArr[indexPath.row];
    self.playurl=model.playUrl;
    self.model=model;
    [self.tab reloadData];
  
}


@end
