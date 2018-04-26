//
//  ZSPageView.m
//  组件封装
//
//  Created by TaoShang on 2018/3/29.
//  Copyright © 2018年 TaoShang. All rights reserved.
//

#import "ZSPageView.h"

@interface ZSPageView ()<ZSTitleViewDelegate>
@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,strong) ZSTitleStyle *style;
@property (nonatomic,strong) NSMutableArray<UIViewController *> *vcs;
@property (nonatomic,strong) UIViewController *presentVC;
@property (nonatomic,strong) ZSTitleView *titleView;
@property (nonatomic,strong) ZSContentView *contentView;
@end
@implementation ZSPageView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles childVCs:(NSMutableArray *)childVCs presentVC:(UIViewController *)presentVC style:(ZSTitleStyle *)style{
    if (self = [super initWithFrame:frame]) {
        self.titles = titles;
        self.style = style;
        self.vcs = childVCs;
        self.presentVC = presentVC;
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    [self setupTitleView];
    [self setupContentView];
}

- (void)setupTitleView{
    CGRect rect = CGRectMake(0, 0, self.bounds.size.width, self.style.titleHeight);
    ZSTitleView *titleView = [[ZSTitleView alloc] initWithFrame:rect titles:self.titles style:self.style];
    [self addSubview:titleView];
    titleView.backgroundColor = [UIColor whiteColor];
    self.titleView = titleView;
    
    NSLog(@"%@",[self changeUIColorToRGB:[UIColor redColor]]);
    
}

- (void)setupContentView{
    CGRect rect2 = CGRectMake(0, self.style.titleHeight, self.bounds.size.width, self.bounds.size.height-self.style.titleHeight);
    ZSContentView *contentView = [[ZSContentView alloc] initWithFrame:rect2 childVCs:self.vcs presentVC:self.presentVC];
    [self addSubview:contentView];
    contentView.backgroundColor = [UIColor randomColor];
    contentView.isUseAnimating = NO;
    self.contentView = contentView;
    self.titleView.delegate = (id)self.contentView;
    self.contentView.delegate = (id)self.titleView;
}


- (NSMutableArray *)changeUIColorToRGB:(UIColor *)color
{
    NSMutableArray *RGBStrValueArr = [[NSMutableArray alloc] init];
    NSString *RGBStr = nil;
    NSString *RGBValue = [NSString stringWithFormat:@"%@",color];
    NSArray *RGBArr = [RGBValue componentsSeparatedByString:@" "];
    int r = [[RGBArr objectAtIndex:1] intValue] * 255;
    RGBStr = [NSString stringWithFormat:@"%d",r];
    [RGBStrValueArr addObject:RGBStr];
    int g = [[RGBArr objectAtIndex:2] intValue] * 255;
    RGBStr = [NSString stringWithFormat:@"%d",g];
    [RGBStrValueArr addObject:RGBStr];
    int b = [[RGBArr objectAtIndex:3] intValue] * 255;
    RGBStr = [NSString stringWithFormat:@"%d",b];
    [RGBStrValueArr addObject:RGBStr];
    return RGBStrValueArr;
}



@end
