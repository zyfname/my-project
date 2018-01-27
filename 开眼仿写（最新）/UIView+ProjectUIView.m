//
//  UIView+ProjectUIView.m
//  movieProject
//
//  Created by HH on 2017/12/17.
//  Copyright © 2017年 lqf. All rights reserved.
//

#import "UIView+ProjectUIView.h"

@implementation UIView (ProjectUIView)


-(CGFloat)zyf_width{
    return self.frame.size.width;
}
-(void)setZyf_width:(CGFloat)zyf_width{
    CGRect  frame=self.frame;
    frame.size.width=zyf_width;
    self.frame=frame;
}


-(CGFloat)zyf_height{
    return self.frame.size.height;
}


-(void)setZyf_height:(CGFloat)zyf_height
{
    
    CGRect  frame=self.frame;
    frame.size.height=zyf_height;
    self.frame=frame;;
}



-(CGFloat)zyf_x{
    return self.frame.origin.x;
}



-(void)setZyf_x:(CGFloat)zyf_x
{
    CGRect  frame=self.frame;
    frame.origin.x=zyf_x;
    self.frame=frame;
}


-(CGFloat)zyf_y{
    return self.frame.origin.y;
}


-(void)setZyf_y:(CGFloat)zyf_y
{
    
    CGRect  frame=self.frame;
    frame.origin.y=zyf_y;
    self.frame=frame;;
}


-(CGSize)zyf_size{
    return self.frame.size;
}



-(void)setZyf_size:(CGSize)zyf_size
{
    CGRect frame=self.frame;
    frame.size=zyf_size;
    self.frame=frame;
}




- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}



-(CGFloat)zyf_centerX{
    return self.center.x;
}





-(void)setZyf_centerX:(CGFloat)zyf_centerX{
    CGPoint center =self.center   ;
    center.x=zyf_centerX;
    self.center=center;
}


-(CGFloat)zyf_centerY{
    return self.center.y;
}

-(void)setZyf_centerY:(CGFloat)zyf_centerY
{
    
    CGPoint center=self.center;
    center.y=zyf_centerY;
    self.center=center;;
}

@end
