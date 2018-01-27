//
//  UIBarButtonItem+ZYFUIBarButtonItem.h
//  
//
//  Created by HH on 2017/10/6.
//  Copyright © 2017年 HH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ZYFUIBarButtonItem)
+(UIBarButtonItem *)itemWithImage:(NSString *)image target:(id)target heightImage:(NSString *)heightImage action:(SEL)action;
@end
