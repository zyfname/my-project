//
//  MainTabbar.m
//  movieProject
//
//  Created by HH on 2017/12/17.
//  Copyright © 2017年 lqf. All rights reserved.

/**
 这是以五个底部按钮为模板的框架、更改底部 item 个数时，只需要改变count，count要小于5.同时在MainViewController添加相应的子控制器
 若不需要中间的发布按钮，可注释掉响应代码，

 */
 


#import "MainTabbar.h"
@interface MainTabbar()

/** 中间的发布按钮 */
@property (nonatomic, weak) UIButton *publishButton;
@property(nonatomic,assign) int count;
@end
@implementation MainTabbar

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置底部工具栏的背景给图片
     self.backgroundImage = [UIImage imageNamed:@""];
    }
    return  self;
}

#pragma mark - 懒加载
/** 发布按钮 */
- (UIButton *)publishButton
{
    if (!_publishButton) {
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishButton];
        _publishButton = publishButton;
    }
    return _publishButton;
}


#pragma mark - 监听
- (void)publishClick
{
    NSLog(@"12334");
}


#pragma mark --初始化

//必须先有自控制器的添加，才有布局方法的实现，若是没有添加自控制布局方法不实现，视图没有响应控件
-(void)layoutSubviews
{
    
    self.count =4;
    [super layoutSubviews];
    CGFloat buttonW=self.zyf_width/self.count;
    CGFloat buttonH=self.zyf_height;
    CGFloat buttonY=5;
    
    
    
    //按钮索引
    int buttonIndex= 0;
    for (UIView *subview  in self.subviews) {
              // 过滤掉非UITabBarButton
      if (subview.class !=NSClassFromString(@"UITabBarButton"))
      {
          NSLog(@"%@",[subview class]);
          continue;
      }
            CGFloat buttonX= buttonIndex *buttonW;

        subview.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);

      
        //增加索引
        buttonIndex++;
     
    }
    
   

    
    
}

@end
