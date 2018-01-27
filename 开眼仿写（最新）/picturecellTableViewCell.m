//
//  picturecellTableViewCell.m
//  开眼放血（最新）
//
//  Created by a on 2017/12/28.
//  Copyright © 2017年 a. All rights reserved.
//

#import "picturecellTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "chuangyimodeul.h"
@interface picturecellTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UIImageView *userimageview;
@property (weak, nonatomic) IBOutlet UILabel *zhubiaoti;
@property (weak, nonatomic) IBOutlet UILabel *fubiaoti;
@property(nonatomic,strong)UILabel *playtime;

@end

@implementation picturecellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)layoutSubviews
{
    self.imageView.frame=CGRectMake(10, 15, self.bounds.size.width-20, 225);
    NSLog(@"%f",self.bounds.size.width);
    self.imageView.layer.cornerRadius=10;
    self.imageView.layer.masksToBounds=YES;
    
    self.userimageview.frame=CGRectMake(10, 245, 40, 40);
    self.userimageview.layer.cornerRadius=20;
    self.userimageview.layer.masksToBounds=YES;
    
    
    self.zhubiaoti.frame=CGRectMake(60, 245, 305, 20);
    self.fubiaoti.frame=CGRectMake(60, 265, 305, 20);
    self.playtime=[[UILabel alloc]initWithFrame:CGRectMake(315, 215, 50, 20)];
    self.playtime.textColor=[UIColor whiteColor];
    self.playtime.backgroundColor=[UIColor blackColor];
     self.playtime.text=@"01:23";
    [self addSubview:_playtime];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(chuangyimodeul *)model

{
    
    
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.coverForFeed]];
    [self.userimageview sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    
    self.zhubiaoti.text =model.title;
    self.fubiaoti.text =[NSString stringWithFormat:@"%@  /  #%@",model.name,model.category];
    
}
@end
