//
//  ZSTitleView.h
//  组件封装
//
//  Created by TaoShang on 2018/3/29.
//  Copyright © 2018年 TaoShang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZSTitleStyle.h"
#import "UIColor+extension.h"
@class ZSTitleView;
@protocol ZSTitleViewDelegate<NSObject>
@optional
- (void)titleView:(ZSTitleView *)titleView targetIndex:(NSInteger)targetIndex;

@end
@interface ZSTitleView : UIView
@property (nonatomic,weak) id <ZSTitleViewDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles style:(ZSTitleStyle *)style;
@end
