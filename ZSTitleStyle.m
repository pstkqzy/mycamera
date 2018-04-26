//
//  ZSTitleStyle.m
//  组件封装
//
//  Created by TaoShang on 2018/3/29.
//  Copyright © 2018年 TaoShang. All rights reserved.
//

#import "ZSTitleStyle.h"

@implementation ZSTitleStyle
-(UIColor *)normalTextColor{
    if (!_normalTextColor) {
        _normalTextColor = [UIColor blackColor];
    }
    return _normalTextColor;
}
- (UIColor *)selectTextColor{
    if (!_selectTextColor) {
        _selectTextColor = [UIColor colorWithRed:0.3 green:0.5 blue:0.7 alpha:1];
    }
    return _selectTextColor;
}

-(CGFloat)titleHeight{
    if (!_titleHeight) {
        _titleHeight = 44;
    }
    return _titleHeight;
}
- (CGFloat)itemMargin{
    if (!_itemMargin) {
        _itemMargin = 20;
    }
    return _itemMargin;
}

- (CGFloat)fontSize
{
    if (!_fontSize) {
        _fontSize = 16;
    }
    return _fontSize;
}

- (CGFloat)scrollLineHeight{
    if (!_scrollLineHeight) {
        _scrollLineHeight = 2;
    }
    return _scrollLineHeight;
}

- (UIColor *)scrollLineColor{
    if (!_scrollLineColor) {
        _scrollLineColor = [UIColor redColor];
    }
    return _scrollLineColor;
}

@end
