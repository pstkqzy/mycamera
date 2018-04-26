//
//  ZSContentView.h
//  组件封装
//
//  Created by TaoShang on 2018/3/29.
//  Copyright © 2018年 TaoShang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZSContentView;
@protocol ZSContentViewDelegate<NSObject>
@optional

- (void)contentView:(ZSContentView *)contentView targetIndex:(NSInteger)targetIndex;

- (void)contentView:(ZSContentView *)contentView targetIndex:(NSInteger)targetIndex progress:(CGFloat)progress;


@end

@interface ZSContentView : UIView
@property (assign,nonatomic) BOOL isUseAnimating;

@property (weak,nonatomic) id <ZSContentViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame childVCs:(NSMutableArray<UIViewController *> *)childVCs presentVC:(UIViewController *)present;
@end




