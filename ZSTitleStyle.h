//
//  ZSTitleStyle.h
//  组件封装
//
//  Created by TaoShang on 2018/3/29.
//  Copyright © 2018年 TaoShang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define isIPhoneX ([UIScreen mainScreen].bounds.size.height == 812)
@interface ZSTitleStyle : NSObject

/**
 标题属性
 */
@property (nonatomic,assign) CGFloat titleHeight;
@property (nonatomic,strong) UIColor *normalTextColor;
@property (nonatomic,strong) UIColor *selectTextColor;
@property (nonatomic,assign) CGFloat fontSize;

/**
 是否可以滚动
 */
@property (nonatomic,assign) BOOL isScrollEnable;


/**
 标题的间距
 */
@property (nonatomic,assign) CGFloat itemMargin;


/**
 自动颜色渐变
 */
@property (nonatomic,assign) BOOL adjustColorEnable;



/**
 滚动条的属性
 */
@property (nonatomic,assign) BOOL isShowScrollLine;
@property (nonatomic,assign) CGFloat scrollLineHeight;
@property (nonatomic,strong) UIColor *scrollLineColor;

@end
