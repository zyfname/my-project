//
//  chuangyimodeul.h
//  开眼放血（最新）
//
//  Created by a on 2017/12/29.
//  Copyright © 2017年 a. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface chuangyimodeul : NSObject
@property (nonatomic, copy) NSString *actionUrl;
@property (nonatomic, copy) NSString *dataType;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *miaoshu;
@property (nonatomic, copy) NSString *type;


@property (nonatomic, assign)CGFloat cellHeight;

//标题
@property (nonatomic, copy) NSString *title;


//图片
@property (nonatomic, copy) NSString *coverForFeed;

//分类
@property (nonatomic, copy) NSString *category;

//播放路径
@property (nonatomic, copy) NSString *playUrl;

//作者头像
@property (nonatomic, copy) NSString *icon;
@end
