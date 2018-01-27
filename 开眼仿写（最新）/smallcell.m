//
//  smallcell.m
//  开眼放血（最新）
//
//  Created by a on 2018/1/22.
//  Copyright © 2018年 a. All rights reserved.
//

#import "smallcell.h"
#import "UIImageView+WebCache.h"
#import "chuangyimodeul.h"


@interface smallcell ()
@property (weak, nonatomic) IBOutlet UIImageView *smallimageview1;
@property (weak, nonatomic) IBOutlet UILabel *zhulabel1;

@property (weak, nonatomic) IBOutlet UILabel *fulabel1;


@end
@implementation smallcell

- (void)awakeFromNib {
    [super awakeFromNib];
   
}


-(void)layoutSubviews
{
    _smallimageview1.frame=CGRectMake(10, 10, self.bounds.size.width/2-15, 125);
    _zhulabel1.frame= CGRectMake(self.bounds.size.width/2+10,10, (self.bounds.size.width-40)/2, 65);
    _fulabel1.frame=CGRectMake(self.bounds.size.width/2+10,85, (self.bounds.size.width-40)/2, 65);
    _zhulabel1.numberOfLines=0;
    
    
}


-(void)setModel2:(chuangyimodeul *)model2
{
    [self.smallimageview1 sd_setImageWithURL:[NSURL URLWithString:model2.coverForFeed]];
    self.zhulabel1.text = model2.title;
    self.fulabel1.text = model2.category;
}



@end
