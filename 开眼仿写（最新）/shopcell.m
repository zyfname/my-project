//
//  shopcell.m
//  开眼放血（最新）
//
//  Created by a on 2017/12/26.
//  Copyright © 2017年 a. All rights reserved.
//

#import "shopcell.h"
#import "UIImageView+WebCache.h"
#import "chuangyimodeul.h"



@interface shopcell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *author;

@end

@implementation shopcell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    
    
}

-(void)setModel:(chuangyimodeul *)model
{
    
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.coverForFeed]];
    [self.author sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    self.nameLabel.text = model.title;
      self.priceLabel.text = model.category;
   
}

@end
