//
//  ZYFQuckLoginButton.m
//  百思不得姐
//
//  Created by HH on 2017/10/8.
//  Copyright © 2017年 HH. All rights reserved.
//

#import "ZYFQuckLoginButton.h"
#import "UIView+ProjectUIView.h"
@implementation ZYFQuckLoginButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib
{
    self.titleLabel.textAlignment =NSTextAlignmentCenter;
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.zyf_y=0;
    self.imageView.zyf_centerX=self.zyf_width*0.5;
    
    self.titleLabel.zyf_x=0;
    self.titleLabel.zyf_y=self.imageView.zyf_y+self.imageView.frame.size.height;
    self.titleLabel.zyf_height=self.zyf_height-self.titleLabel.zyf_y;
    self.titleLabel.zyf_width=self.zyf_width;
}
@end
