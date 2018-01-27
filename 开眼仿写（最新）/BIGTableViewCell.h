//
//  BIGTableViewCell.h
//  开眼放血（最新）
//
//  Created by a on 2017/12/26.
//  Copyright © 2017年 a. All rights reserved.
//

#import <UIKit/UIKit.h>
@class chuangyimodeul;
@interface BIGTableViewCell : UITableViewCell
@property (nonatomic, strong) chuangyimodeul *model;
@property (nonatomic, strong) NSString *topic;
@property (nonatomic, strong) NSString *videotime;
@property (nonatomic, strong) NSString *imagename;
@end
