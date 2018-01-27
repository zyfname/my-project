//
//  chuangyimodeul.m
//  开眼放血（最新）
//
//  Created by a on 2017/12/29.
//  Copyright © 2017年 a. All rights reserved.
//

#import "chuangyimodeul.h"
#import "UIView+ProjectUIView.h"

@implementation chuangyimodeul
-(CGFloat)cellHeight
{
    
    
    // 如果cell的高度已经计算过, 就直接返回
    if (_cellHeight) return _cellHeight;
    
    _cellHeight=10;
    CGFloat textMaxW = [UIScreen mainScreen].bounds.size.width - 2 * 10;
      CGFloat contentH = textMaxW * 0.666;
    _cellHeight=_cellHeight+contentH+10;
    return _cellHeight;
}
@end
