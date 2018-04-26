//
//  ZSPageView.h
//  组件封装
//
//  Created by TaoShang on 2018/3/29.
//  Copyright © 2018年 TaoShang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZSTitleStyle.h"
#import "ZSTitleView.h"
#import "ZSContentView.h"
#import "UIColor+extension.h"

@interface ZSPageView : UIView


- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles childVCs:(NSMutableArray *)childVCs presentVC:(UIViewController *)presentVC style:(ZSTitleStyle *)style;
@end
