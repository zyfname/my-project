//
//  BIGTableViewCell.m
//  开眼放血（最新）
//
//  Created by a on 2017/12/26.
//  Copyright © 2017年 a. All rights reserved.
//

#import "BIGTableViewCell.h"
@interface BIGTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageview;

@property (weak, nonatomic) IBOutlet UILabel *topicLabel;
@property (weak, nonatomic) IBOutlet UILabel *videotimeLabel;
@end
@implementation BIGTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setVideotime:(NSString *)videotime{
     _videotime= videotime;
    self.videotimeLabel.text = videotime;
}

- (void)setTopic:(NSString *)topic
{
    _topic= topic;
    self.topicLabel.text = topic;
}

- (void)setImage:(NSString *)imagename
{
    _imagename= imagename;
    self.imageview.image = [UIImage imageNamed:imagename];
}


-(void)setModel:(chuangyimodeul *)model
{
    
 }


@end
