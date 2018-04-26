//
//  ViewController.m
//  组件封装
//
//  Created by TaoShang on 2018/3/29.
//  Copyright © 2018年 TaoShang. All rights reserved.
//

#import "ViewController.h"
#import "ZSPageView.h"
@interface ViewController ()
@property (nonatomic,strong) NSArray<NSString *> *titles;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titles = @[@"游戏游戏",@"美女",@"趣玩",@"娱乐",@"颜值颜值",@"推荐推荐推荐",@"个人人",@"游戏",@"美女231131",@"趣玩"];
    [self setupChildVCs];
    self.automaticallyAdjustsScrollViewInsets = NO;
//    char a = 11111111111111111111;
//    printf("a = %c",a);
}

- (void)setupChildVCs{
    NSMutableArray *VCs = [NSMutableArray array];
    ZSTitleStyle *style = [ZSTitleStyle new];
    style.isShowScrollLine = YES;
    style.isScrollEnable = YES;
    for (int i = 0; i < self.titles.count; i++) {
        UIViewController *vc = [UIViewController new];
        vc.view.backgroundColor = [UIColor randomColor];
        [VCs addObject:vc];
    }
    CGFloat navHeight = isIPhoneX ? 88 : 64;
    CGRect pageViewFrame = CGRectMake(0, navHeight, self.view.bounds.size.width, self.view.bounds.size.height-navHeight);
    
    ZSPageView *pageView = [[ZSPageView alloc] initWithFrame:pageViewFrame titles:self.titles childVCs:VCs presentVC:self style:style];
//    pageView.backgroundColor = [UIColor randomColor];
    [self.view addSubview:pageView];
}




@end
