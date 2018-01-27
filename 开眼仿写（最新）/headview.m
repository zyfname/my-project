//
//  headview.m
//  开眼放血（最新）
//
//  Created by a on 2017/12/30.
//  Copyright © 2017年 a. All rights reserved.
//

#import "headview.h"
#import "UIImageView+WebCache.h"
#import "chuangyimodeul.h"


@interface headview ()
@property(nonatomic,strong)UIImageView *bigimageview;
@property(nonatomic,strong)UIImageView *bigimageview2;
@property(nonatomic,strong)UIImageView *smallimageview1;
@property(nonatomic,strong)UIImageView *smallimageview2;
@property(nonatomic,strong)UIImageView *smallimageview3;
@property(nonatomic,strong)UIImageView *smallimageview4;
@property(nonatomic,strong)UILabel *zhulabel1;
@property(nonatomic,strong)UILabel *zhulabel2;
@property(nonatomic,strong)UILabel *zhulabel3;
@property(nonatomic,strong)UILabel *zhulabel4;
@property(nonatomic,strong)UILabel *fulabel1;
@property(nonatomic,strong)UILabel *fulabel2;
@property(nonatomic,strong)UILabel *fulabel3;
@property(nonatomic,strong)UILabel *fulabel4;

@property(nonatomic,strong)UILabel *headtitle;
@property(nonatomic,strong)UILabel *headtitle2;

@end

@implementation headview

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        _headtitle= [[UILabel alloc]init];
        _bigimageview= [[UIImageView alloc]init];
        _smallimageview1 = [[UIImageView alloc]init];
        _fulabel1 = [[UILabel alloc]init];
        _zhulabel1 = [[UILabel alloc]init];
        _smallimageview2 = [[UIImageView alloc]init];
        _zhulabel2 = [[UILabel alloc]init];
        _fulabel2 = [[UILabel alloc]init];
        
        _headtitle2= [[UILabel alloc]init];
        _bigimageview2= [[UIImageView alloc]init];
        _smallimageview3 = [[UIImageView alloc]init];
        _fulabel3 = [[UILabel alloc]init];
        _zhulabel3 = [[UILabel alloc]init];
        _smallimageview4= [[UIImageView alloc]init];
        _zhulabel4= [[UILabel alloc]init];
        _fulabel4 = [[UILabel alloc]init];
    
        
        
        
        [self addSubview:_headtitle];
        [self addSubview:_bigimageview];
        
        [self addSubview:_fulabel2];
        [self addSubview:_zhulabel2];
        [self addSubview:_smallimageview2];
        
        [self addSubview:_fulabel1];
        [self addSubview:_zhulabel1];
        [self addSubview:_smallimageview1];
      
        [self addSubview:_headtitle2];
        [self addSubview:_bigimageview2];
        
        [self addSubview:_fulabel3];
        [self addSubview:_zhulabel3];
        [self addSubview:_smallimageview3];
        
        [self addSubview:_fulabel4];
        [self addSubview:_zhulabel4];
        [self addSubview:_smallimageview4];
        
        for (UIView *v in self.subviews) {
            v.layer.cornerRadius=15;
            v.layer.masksToBounds=YES;
          
        }
       
    }
    return self;
}

-(void)layoutSubviews
{
    _headtitle.frame =CGRectMake(10, 20, self.bounds.size.width-20, 50);
    _bigimageview.frame=CGRectMake(10, 80, self.bounds.size.width-20, 220);
    _smallimageview1.frame=CGRectMake(10, 310, self.bounds.size.width/2-15, 125);
    _zhulabel1.frame= CGRectMake(self.bounds.size.width/2+10, 310, (self.bounds.size.width-40)/2, 65);
    _fulabel1.frame=CGRectMake(self.bounds.size.width/2+10,385, (self.bounds.size.width-40)/2, 65);
    _smallimageview2.frame=CGRectMake(10, 465, self.bounds.size.width/2-10, 125);
    _zhulabel2.frame=CGRectMake(self.bounds.size.width/2+10, 465, (self.bounds.size.width-40)/2, 70);
    _fulabel2.frame =CGRectMake(self.bounds.size.width/2+10, 545, (self.bounds.size.width-40)/2, 70);
    _headtitle2.frame =CGRectMake(10, 635, self.bounds.size.width-20, 50);
    _bigimageview2.frame=CGRectMake(10, 695, self.bounds.size.width-20, 220);
    _smallimageview3.frame=CGRectMake(10, 925, self.bounds.size.width/2-15, 125);
    _zhulabel3.frame=CGRectMake(self.bounds.size.width/2+10, 925, (self.bounds.size.width-40)/2, 65);
    _fulabel3.frame = CGRectMake(self.bounds.size.width/2+10,1000, (self.bounds.size.width-40)/2, 65);
    _smallimageview4.frame =CGRectMake(10, 1080, self.bounds.size.width/2-10, 125);
    _zhulabel4.frame = CGRectMake(self.bounds.size.width/2+10, 1080, (self.bounds.size.width-40)/2, 70);
    _fulabel4.frame = CGRectMake(self.bounds.size.width/2+10, 1160, (self.bounds.size.width-40)/2, 70);
    
    
    _zhulabel4.numberOfLines=0;
    _zhulabel3.numberOfLines=0;
    _zhulabel2.numberOfLines=0;
    _zhulabel1.numberOfLines=0;    
    
}

-(void)setModel1:(chuangyimodeul *)model1

{
    _headtitle.text =@"广告   最近更新 >";
    [self.bigimageview sd_setImageWithURL:[NSURL URLWithString:model1.coverForFeed]];
   
    
}
-(void)setModel4:(chuangyimodeul *)model4

{
    _headtitle2.text =@"广告   最近更新 >";
    [self.bigimageview2 sd_setImageWithURL:[NSURL URLWithString:model4.coverForFeed]];
    
    
    
    
}
-(void)setModel2:(chuangyimodeul *)model2
{
    [self.smallimageview1 sd_setImageWithURL:[NSURL URLWithString:model2.coverForFeed]];
    self.zhulabel1.text = model2.title;
     self.fulabel1.text = model2.category;
}
-(void)setModel3:(chuangyimodeul *)model3
{
    [self.smallimageview3 sd_setImageWithURL:[NSURL URLWithString:model3.coverForFeed]];
    self.zhulabel3.text = model3.title;
    self.fulabel3.text = model3.category;
}

-(void)setModel5:(chuangyimodeul *)model5
{
    [self.smallimageview2 sd_setImageWithURL:[NSURL URLWithString:model5.coverForFeed]];
    self.zhulabel2.text = model5.title;
    self.fulabel2.text = model5.category;

}
-(void)setModel0:(chuangyimodeul *)model0
{
    [self.smallimageview4 sd_setImageWithURL:[NSURL URLWithString:model0.coverForFeed]];
    self.zhulabel4.text = model0.title;
    self.fulabel4.text = model0.category;
}


@end
