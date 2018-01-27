//
//  homeViewController.m
//  开眼放血（最新）
//
//  Created by a on 2017/12/26.
//  Copyright © 2017年 a. All rights reserved.
//

#import "homeViewController.h"
#import "myViewController.h"
#import "shouyeViewController.h"
#import "OneViewController.h"
#import "ribaoTableViewController.h"
#import "chuangyiViewController.h"
#import "musicTableViewController.h"
#import "animationTableViewController.h"
#import "fashionTableViewController.h"
#import "PolularScienceTableViewController.h"
#import "FunnyTableViewController.h"

@interface homeViewController ()
@property(nonatomic,weak)UIButton *selectTitleButton;
@property (nonatomic, weak) UIScrollView *scrollview;
@property (nonatomic, strong) UIScrollView *sc;
@property (nonatomic, weak) UIView *titleView;
@property (nonatomic, weak) UIButton *btn;
@end

@implementation homeViewController

-(void)viewDidLoad
{
    
    [super viewDidLoad];
    
    
    [self setupNav];
    
    [self setupChildViewController];
    
    [self setupScrollView];
    [self addChildView];
   _btn =self.sc.subviews[0];
    _btn.selected=YES;
   
}



-(void)setupNav
{
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
   
    self.sc = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0
                                                            , self.view.frame.size.width/7*5, 30)];
 self.sc.showsHorizontalScrollIndicator=NO;
     self.sc.showsVerticalScrollIndicator=NO;
   
    self.sc.backgroundColor = [UIColor whiteColor];
    [ self.sc setContentSize:CGSizeMake(self.view.frame.size.width/7*8, 30)];
    
    self.navigationItem.titleView=_sc;
    
    NSArray *titles = @[@"发现", @"日报", @"创意", @"音乐", @"科普", @"搞笑", @"时尚",@"动画"];
    NSUInteger count = titles.count;
    CGFloat titleButtonW = self.view.zyf_width / 7;
    CGFloat titleButtonH =30;

    for (NSUInteger i = 0; i < count; i++) {
        // 创建
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.tag=i;
        [titleButton addTarget:self action:@selector(titleclick:) forControlEvents:UIControlEventTouchUpInside];
        
        // 设置数据
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
      
        // 设置frame
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
       
        [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        if (i%2==0) {
            titleButton.backgroundColor = [UIColor yellowColor];
        }

        [self.sc addSubview:titleButton];
    }
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon"
                                                                    target:self heightImage:@"MainTagSubIconClick"  action:nil];
    
}



//添加子控制器
-(void)setupChildViewController
{
    shouyeViewController *all = [[shouyeViewController alloc]init];
    [self addChildViewController:all];
    
     ribaoTableViewController *voice = [[ribaoTableViewController alloc]init];
    [self addChildViewController:voice];
    
    chuangyiViewController  *image = [[chuangyiViewController alloc]init];
    [self addChildViewController:image];
    
    musicTableViewController *word = [[musicTableViewController alloc]init];
    [self addChildViewController:word];

    
    PolularScienceTableViewController *viewcontroller1 = [[PolularScienceTableViewController alloc]init];
    [self addChildViewController:viewcontroller1];
    
    FunnyTableViewController *voice1 = [[FunnyTableViewController alloc]init];
    [self addChildViewController:voice1];
    
    fashionTableViewController *image1 = [[fashionTableViewController alloc]init];
    [self addChildViewController:image1];
    
    animationTableViewController *all2= [[animationTableViewController alloc]init];
    [self addChildViewController:all2];
    
    
  
}


-(void)setupScrollView
{
    // 不允许自动调整scrollView的内边距
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    UIScrollView *scrollview = [[UIScrollView alloc]init];
    
    scrollview.backgroundColor=ZYFRa4ndomColor;
    scrollview.frame=self.view.bounds;
    scrollview.pagingEnabled=YES;
    scrollview.showsHorizontalScrollIndicator=NO;
    scrollview.delegate=self;
    
    scrollview.showsVerticalScrollIndicator=NO;
    
   NSUInteger count =self.childViewControllers.count;
    
    
    scrollview.contentSize=CGSizeMake(count*self.view.zyf_width, 0);
    [self.view addSubview:scrollview];
    self.scrollview =scrollview;
    
    
}

#pragma mark---uiscrollviewdelegate
/**
 * 在scrollView滚动动画结束时, 就会调用这个方法
 * 前提: 使用setContentOffset:animated:或者scrollRectVisible:animated:方法让scrollView产生滚动动画
 */
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self addChildView];
    
}

/**
 * 在scrollView滚动动画结束时,就会调用这个方法,前提: 人为拖拽scrollView产生的滚动动画
 */

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //选中点击对应的按钮
    NSUInteger index = scrollView.contentOffset.x/scrollView.zyf_width;
 
    UIButton *titlebutton =self.sc.subviews[index];



 [self titleclick:titlebutton];
    [self addChildView];
  
    
}


#pragma mark--监听点击
-(void)titleclick:(UIButton *)titleButton
{
    _btn.selected=NO;
    // 控制按钮状态
    self.selectTitleButton.selected = NO;
    titleButton.selected = YES;
    self.selectTitleButton = titleButton;
    

    if (titleButton.tag>2&&titleButton.tag<self.sc.subviews.count-2) {
        CGPoint smalloffset = self.sc.contentOffset;
        smalloffset.x = (titleButton.tag-2)*self.sc.subviews[0].zyf_width;
        self.sc.contentOffset=smalloffset;
    }else if(titleButton.tag==0)
    {
        CGPoint smalloffset = self.sc.contentOffset;
         smalloffset.x = (titleButton.tag)*self.sc.subviews[0].zyf_width;
        self.sc.contentOffset=smalloffset;
    }
    
    CGPoint offset= self.scrollview.contentOffset;
    
    offset.x = titleButton.tag*self.scrollview.zyf_width;
    [self.scrollview setContentOffset:offset animated:YES];
    
   
    
}

-(void)addChildView{
    //添加自控制器到scrollview中
    NSUInteger index = self.scrollview.contentOffset.x/self.scrollview.zyf_width;
    UIViewController *childerView =self.childViewControllers[index];
    if ([childerView isViewLoaded]) return;
    childerView.view.frame=self.scrollview.bounds;
    [self.scrollview addSubview:childerView.view];
}



@end
