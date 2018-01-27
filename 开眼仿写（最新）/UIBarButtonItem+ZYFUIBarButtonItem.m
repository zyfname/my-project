//
//  UIBarButtonItem+ZYFUIBarButtonItem.m
//  
//
//  Created by HH on 2017/10/6.
//  Copyright © 2017年 HH. All rights reserved.
//

#import "UIBarButtonItem+ZYFUIBarButtonItem.h"

@implementation UIBarButtonItem (ZYFUIBarButtonItem)

//快速设置导航栏的item按钮的初始化方法
/**
 *使用示例：设置做导航按钮
     self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon"
     target:self heightImage:@"MainTagSubIconClick"  action:@selector(tagClick)];
 */
+(UIBarButtonItem *)itemWithImage:(NSString *)image target:(id)target heightImage:(NSString *)heightImage action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [ button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [ button setImage:[UIImage imageNamed:heightImage] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    
    return [[self alloc]initWithCustomView:button];
}
@end
