//
//  ZSContentView.m
//  组件封装
//
//  Created by TaoShang on 2018/3/29.
//  Copyright © 2018年 TaoShang. All rights reserved.
//

#import "ZSContentView.h"
#import "ZSPageView.h"
@interface ZSContentView ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong,nonatomic) UIViewController *present;
@property (strong,nonatomic) NSMutableArray<UIViewController *> *childVCs;
@property (strong,nonatomic) UICollectionView *collectionView;
@property (assign,nonatomic) CGFloat startOffsetX;

@property (assign,nonatomic) BOOL isForbidScroll;
@end
@implementation ZSContentView

- (instancetype)initWithFrame:(CGRect)frame childVCs:(NSMutableArray<UIViewController *> *)childVCs presentVC:(UIViewController *)present{
    if (self = [super initWithFrame:frame]) {
        self.present = present;
        self.childVCs = childVCs;
        [self addSubview:self.collectionView];
    }
    return self;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = self.bounds.size;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.childVCs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    UIViewController *vc = self.childVCs[indexPath.row];
    vc.view.frame = cell.contentView.bounds;
    vc.view.backgroundColor = [UIColor randomColor];
    [self.present addChildViewController:vc];
    [cell.contentView addSubview:vc.view];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}
#pragma mark -- ZSTitleViewDelegate
- (void)titleView:(ZSTitleView *)titleView targetIndex:(NSInteger)targetIndex{
    self.isForbidScroll = YES;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:targetIndex inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:self.isUseAnimating];
}

#pragma mark -- UICollectionViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate) {
        NSInteger currentIndex  = (NSInteger)(scrollView.contentOffset.x/scrollView.bounds.size.width);
        if (self.delegate && [self.delegate respondsToSelector:@selector(contentView:targetIndex:)]) {
            [self.delegate contentView:self targetIndex:currentIndex];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (self.isForbidScroll) return;
    NSInteger currentIndex  = (NSInteger)(scrollView.contentOffset.x/scrollView.bounds.size.width);
    if (self.delegate && [self.delegate respondsToSelector:@selector(contentView:targetIndex:)]) {
        [self.delegate contentView:self targetIndex:currentIndex];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.isForbidScroll) return;
    if (self.startOffsetX == scrollView.contentOffset.x) return;
    
    NSInteger targetIndex = 0;
    
    CGFloat progress = 0.0;
    NSInteger currentIndex = (NSInteger)(self.startOffsetX/scrollView.bounds.size.width);
    if (self.startOffsetX < scrollView.contentOffset.x) {
        targetIndex = currentIndex+1;
        
        if (targetIndex > self.childVCs.count) {
            targetIndex = self.childVCs.count-1;
        }
        progress = (scrollView.contentOffset.x - self.startOffsetX)/scrollView.bounds.size.width;
        
    }else{
        targetIndex = currentIndex-1;
        
        if (targetIndex < 0) {
            targetIndex = 0;
        }
        progress = (self.startOffsetX-scrollView.contentOffset.x)/scrollView.bounds.size.width;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(contentView:targetIndex:progress:)]) {
        [self.delegate contentView:self targetIndex:targetIndex progress:progress];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.startOffsetX = scrollView.contentOffset.x;
    self.isForbidScroll = NO;
}


@end
