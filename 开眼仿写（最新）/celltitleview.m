//
//  celltitleview.m
//  开眼放血（最新）
//
//  Created by a on 2018/1/1.
//  Copyright © 2018年 a. All rights reserved.
//

#import "celltitleview.h"
#import "chuangyimodeul.h"
#import "UIImageView+WebCache.h"
@interface celltitleview ()
@property(strong,nonatomic) UIImageView *myimageview;
@property(strong,nonatomic)UILabel *title;
@property(strong,nonatomic)UILabel *subtitle;
@property(strong,nonatomic)UIButton *guanzhu;
@end

@implementation celltitleview
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.myimageview = [[UIImageView alloc]init];
        self.title=[[UILabel alloc]init];
        self.myimageview.layer.cornerRadius=20;
        self.myimageview.layer.masksToBounds=YES;
        self.subtitle=[[UILabel alloc]init];
        self.guanzhu = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [self addSubview: self.myimageview ];
        [self addSubview: self.title];
        [self addSubview: self.subtitle];
        [self addSubview: self.guanzhu ];
    }
    return self;
}
-(void)layoutSubviews

{
    
    [ self.guanzhu.layer setMasksToBounds:YES];
    [ self.guanzhu.layer setCornerRadius:5.0];
    self.guanzhu.layer.borderWidth=1;
    self.myimageview.frame= CGRectMake(10, 15, 40, 40);
  self.title.frame = CGRectMake(55, 15, self.bounds.size.width-115, 20);
    self.subtitle.frame = CGRectMake(55, 35, self.bounds.size.width-115, 20);
    [self.guanzhu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.guanzhu.frame= CGRectMake(self.bounds.size.width-60, 15, 50, 20);
   
    [ self.guanzhu addTarget:self action:@selector(getauthorlist) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setModel:(chuangyimodeul *)model
{
    
    [self.myimageview sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    [self.title setText:model.title];
    self.subtitle.text = model.miaoshu;
    [self.guanzhu setTitle:@"关注" forState:UIControlStateNormal];
}

-(void)getauthorlist{
    NSLog(@"你点击了关注。");
}


@end
