//
//  mycell.m
//  开眼放血（最新）
//
//  Created by a on 2018/1/10.
//  Copyright © 2018年 a. All rights reserved.
//

#import "mycell.h"
#import "UIImageView+WebCache.h"
#import "chuangyimodeul.h"
@interface mycell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UILabel *zhuti;
@property (weak, nonatomic) IBOutlet UILabel *fubiaoti;


@end

@implementation mycell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)layoutSubviews
    {
        self.imageview.frame = CGRectMake(10, 10,(self.bounds.size.width-30)/2, 130);
        
        self.zhuti.frame=CGRectMake(20+(self.bounds.size.width-30)/2, 10,(self.bounds.size.width-30)/2, 65);
        self.zhuti.numberOfLines=0;
        self.fubiaoti.frame=CGRectMake(20+(self.bounds.size.width-30)/2, 75,(self.bounds.size.width-30)/2, 65);
        [self addSubview:self.imageview];
        [self addSubview:self.zhuti];
        [self addSubview:self.fubiaoti];
        
        
    }
  

-(void)setModel:(chuangyimodeul *)model{
    [self.imageview sd_setImageWithURL:[NSURL URLWithString:model.coverForFeed]];
    self.zhuti .text = model.title;
    self.fubiaoti.text= [NSString stringWithFormat:@"#%@",model.category];
    
    
    
}

@end
