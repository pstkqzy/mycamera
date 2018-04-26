//
//  ZSTitleView.m
//  组件封装
//
//  Created by TaoShang on 2018/3/29.
//  Copyright © 2018年 TaoShang. All rights reserved.
//

#import "ZSTitleView.h"
#import "ZSTitleStyle.h"
#import "ZSPageView.h"
//@class ZSContentView;
//#import "UIColor+extension.h"

@interface ZSTitleView ()<ZSContentViewDelegate>
@property (nonatomic,strong) NSArray<NSString *> *titles;
@property (nonatomic,strong) ZSTitleStyle *style;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray<UILabel *> *labels;
@property (nonatomic,assign) NSUInteger currentIndex;
@property (nonatomic,assign) double progress;

@property (nonatomic,strong) UIView *bottomView;
@end
@implementation ZSTitleView
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    return _scrollView;
}
- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [UIView new];
        if (self.style.scrollLineColor) {
            _bottomView.backgroundColor = self.style.scrollLineColor;
        }else{
            _bottomView.backgroundColor = [UIColor blueColor];
        }
        
        CGRect frame = _bottomView.frame;
        if (self.style.scrollLineHeight != 0) {
            frame.size.height = self.style.scrollLineHeight;
        }else{
            frame.size.height = 2;
        }
        frame.origin.y = self.bounds.size.height - self.style.scrollLineHeight;
        _bottomView.frame = frame;
    }
    return _bottomView;
}
- (NSMutableArray *)labels{
    if (!_labels) {
        _labels = [NSMutableArray array];
    }
    return _labels;
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles style:(ZSTitleStyle *)style{
    if (self = [super initWithFrame:frame]) {
        self.titles = titles;
        self.style = style;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.scrollsToTop = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    [self setupTitles];
    [self addSubview:self.scrollView];
    if (self.style.isShowScrollLine) {
        [_scrollView addSubview:self.bottomView];
    }
    
}

- (void)setupTitles{
    NSUInteger count = self.titles.count;
    CGFloat height = self.bounds.size.height;
    CGFloat y = 0;
    CGFloat width = 0.0,x = 0.0;
    for (int i = 0; i<count; i++) {
        UILabel *titleLable = [[UILabel alloc] init];
        titleLable.text = self.titles[i];
        titleLable.textColor = i == 0 ? self.style.selectTextColor : self.style.normalTextColor;
        titleLable.font = [UIFont systemFontOfSize:self.style.fontSize];
        titleLable.tag = i;
        titleLable.userInteractionEnabled = YES;
        titleLable.textAlignment = NSTextAlignmentCenter;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleLabelClickWithTap:)];
        [titleLable addGestureRecognizer:tap];
        
//        CGRect bottomViewFrame = self.bottomView.frame;
        if (_style.isScrollEnable) {
            NSString *str = self.titles[i];
            CGRect rect = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : titleLable.font} context:nil];
            width = rect.size.width;
            if (i == 0) {
                x = self.style.itemMargin * 0.5;
                CGRect frame = self.bottomView.frame;
                frame.origin.x = x;
                frame.size.width = width;
                self.bottomView.frame = frame;
            }else{
                UILabel * label = self.labels[i-1];
                x = label.frame.origin.x+label.frame.size.width+_style.itemMargin;
            }
        }else{
            width = self.bounds.size.width/count;
            x = width * i;
            if (i == 0) {
                CGRect frame = self.bottomView.frame;
                frame.origin.x = 0;
                frame.size.width = width;
                self.bottomView.frame = frame;
            }
        }
        titleLable.frame = CGRectMake(x, y, width, height);
        [self.scrollView addSubview:titleLable];
        [self.labels addObject:titleLable];
    }
    self.scrollView.contentSize = self.style.isScrollEnable ? CGSizeMake(self.labels.lastObject.frame.origin.x +self.labels.lastObject.frame.size.width + _style.itemMargin*0.5, self.scrollView.bounds.size.height) : self.scrollView.bounds.size;
    NSLog(@"%@",self.scrollView.subviews);
}

#pragma mark -- 标题label的点击
- (void)titleLabelClickWithTap:(UITapGestureRecognizer *)tap{
    UILabel *targetLabel = (UILabel *)tap.view;
    
    [self adjustTitleLabel:targetLabel.tag];
    if (self.delegate && [self.delegate respondsToSelector:@selector(titleView:targetIndex:)]) {
        [self.delegate titleView:self targetIndex:self.currentIndex];
    }
    if (self.style.isShowScrollLine) {
        [UIView animateWithDuration:.25 animations:^{
            CGRect frame = self.bottomView.frame;
            frame.origin.x = targetLabel.frame.origin.x;
            frame.size.width = targetLabel.frame.size.width;
            self.bottomView.frame = frame;
        }];
    }
    
    
}
#pragma mark -- ZSContentViewDelegate

- (void)contentView:(ZSContentView *)contentView targetIndex:(NSInteger)targetIndex{
    
    [self adjustTitleLabel:targetIndex];
    
}

- (void)contentView:(ZSContentView *)contentView targetIndex:(NSInteger)targetIndex progress:(CGFloat)progress{
    
    UILabel *targetLabel = self.labels[targetIndex];
    UILabel *sourceLabel = self.labels[self.currentIndex];
//
//    NSMutableArray *deltaRGB = [self getRGBDelta:self.style.selectTextColor secondColor:self.style.normalTextColor];
//
//    const double *selectRGB = [self changeUIColorToRGB:self.style.selectTextColor];
//
//    const double *normalRGB = [self changeUIColorToRGB:self.style.normalTextColor];
//
//    float r,g,b,pro;
//
//    r = normalRGB[0] + [deltaRGB[0] floatValue]*progress;
//    g = normalRGB[1] + [deltaRGB[1] floatValue]*progress;
//    b = normalRGB[2] + [deltaRGB[2] floatValue]*progress;
//    targetLabel.textColor = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
//    sourceLabel.textColor = [UIColor colorWithRed:(selectRGB[0] - [deltaRGB.firstObject floatValue]*progress) green:(selectRGB[1] - [deltaRGB[1] floatValue]*progress) blue:(selectRGB[2] - [deltaRGB[2] floatValue]*progress) alpha:1.0];
    if (self.style.isShowScrollLine) {
        CGFloat x = targetLabel.frame.origin.x - sourceLabel.frame.origin.x;
        CGFloat width = targetLabel.frame.size.width - sourceLabel.frame.size.width;
        CGRect bottomViewFrame = self.bottomView.frame;
        bottomViewFrame.origin.x = sourceLabel.frame.origin.x + x * progress;
        bottomViewFrame.size.width = sourceLabel.frame.size.width + width *progress;
        self.bottomView.frame = bottomViewFrame;
    }

}
- (void)adjustTitleLabel:(NSInteger)targetIndex{
    if (targetIndex == self.currentIndex)return;
    UILabel *targetLabel = self.labels[targetIndex];
    UILabel *sourceLabel = self.labels[self.currentIndex];
    
    targetLabel.textColor = self.style.selectTextColor;
    sourceLabel.textColor = self.style.normalTextColor;
    
    
    
    
    self.currentIndex = targetIndex;
    if (self.style.isScrollEnable) {
        CGPoint offset = CGPointMake(targetLabel.center.x - self.scrollView.bounds.size.width*0.5, 0);
        if (offset.x < 0) {
            offset.x = 0;
        }else if (offset.x > self.scrollView.contentSize.width-self.scrollView.bounds.size.width){
            offset.x = self.scrollView.contentSize.width-self.scrollView.bounds.size.width;
        }
        [self.scrollView setContentOffset:offset animated:YES];
    }
}
- (NSMutableArray *)getRGBDelta:(UIColor *)firstColor secondColor:(UIColor *)secondColor{
    const double *first = [self changeUIColorToRGB:firstColor];
    const double *second = [self changeUIColorToRGB:secondColor];
    NSMutableArray *news = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        CGFloat r = first[i] - second[i];
        [news addObject:@(r)];
        
    }
    return news;
}

- (const double *)changeUIColorToRGB:(UIColor *)color
{
    CGColorRef cgColor = color.CGColor;
    const double *compents = CGColorGetComponents(cgColor);
    return compents;
}


@end
