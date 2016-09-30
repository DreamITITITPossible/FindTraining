//
//  AlbumView.m
//  FindTraining
//
//  Created by Jiang on 16/9/28.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "AlbumView.h"
#import "AlbumZoomScrollView.h"

@interface AlbumView ()
<
UIScrollViewDelegate
>
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, retain) NSMutableArray *currentImageArray;
@end
@implementation AlbumView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.currentImageArray = [NSMutableArray array];
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        // CGRectZero 四个值都为0;
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        // 单页时隐藏
        _pageControl.hidesForSinglePage = YES;
        [_pageControl addTarget:self action:@selector(pageControlValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_pageControl];
    }
    return self;
}


- (void)setCurrentNum:(NSInteger)currentNum {
    if (_currentNum != currentNum) {
        _currentNum = currentNum;
    }
    _pageControl.currentPage =  _currentNum;
    _scrollView.contentOffset = CGPointMake(self.bounds.size.width * (_currentNum + 1), 0);
    
}
- (void)setImageArray:(NSArray *)imageArray {
    if (_imageArray != imageArray) {
       
        _imageArray = imageArray;
#pragma mark - 拓展 赋值了两次数组,重复创建!!!  判断是否大于0 如果是就清空
        if (_currentImageArray.count > 0) {
            [_currentImageArray removeAllObjects];
            for (UIView *subView in _scrollView.subviews) {
                if ([subView isKindOfClass:[UIScrollView class]]) {
                    [subView removeFromSuperview];
                }
            }
            
        }
        [_currentImageArray addObject:[_imageArray lastObject]];
        [_currentImageArray addObjectsFromArray:_imageArray];
        [_currentImageArray addObject:[_imageArray firstObject]];
        _scrollView.contentSize = CGSizeMake(self.bounds.size.width * _currentImageArray .count, self.bounds.size.height - 64);
        CGSize pageControlSize = [_pageControl sizeForNumberOfPages:_imageArray.count];
        CGPoint pageControlOrigin = {(self.bounds.size.width - pageControlSize.width) / 2, self.bounds.size.height - pageControlSize.height - 5};
        CGRect pageControlFrame = {pageControlOrigin, pageControlSize};
        _pageControl.frame = pageControlFrame;
        _pageControl.numberOfPages = _imageArray.count;
        _pageControl.currentPage = _currentNum;
        for (int i = 0; i < _currentImageArray.count; i++) {
            CGPoint zoomViewOrigin = {i * self.bounds.size.width, 0};
            CGSize zoomViewSize = self.bounds.size;
            CGRect zoomViewFrame = {zoomViewOrigin, zoomViewSize};
            AlbumZoomScrollView *zoomScrollView = [[AlbumZoomScrollView alloc] initWithFrame:zoomViewFrame];
            zoomScrollView.photoList = _currentImageArray[i];
            zoomScrollView.delegate = self;
            zoomScrollView.maximumZoomScale = 4.0f;
            zoomScrollView.minimumZoomScale = 0.25f;
            [_scrollView addSubview:zoomScrollView];
            _scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
        }
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([scrollView isEqual:_scrollView]) {
        NSInteger pageNumber = scrollView.contentOffset.x / scrollView.bounds.size.width;
        if (0 == pageNumber) {
            pageNumber = _imageArray.count;
        } if (_imageArray.count + 1 == pageNumber) {
            pageNumber = 1;
        }
        _pageControl.currentPage = pageNumber - 1;
        scrollView.contentOffset  = CGPointMake(scrollView.bounds.size.width * pageNumber, 0);
        for (UIView *subView in scrollView.subviews) {
            if ([subView isKindOfClass:[UIScrollView class]]) {
                UIScrollView *subScroView = (UIScrollView *)subView;
                subScroView.zoomScale = 1.0f;
            }
        }
    }
}
- (void)pageControlValueChanged:(UIPageControl *)pageControl {
    [_scrollView setContentOffset:CGPointMake((pageControl.currentPage + 1) * self.bounds.size.width, 0) animated:YES];
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return [scrollView.subviews firstObject];
}

#pragma mark - 拓展_缩小在中心显示
// 正在缩放
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    if (scrollView.contentSize.width <= scrollView.bounds.size.width) {
        UIImageView *imageView = [scrollView.subviews firstObject];
        imageView.center = CGPointMake(scrollView.bounds.size.width / 2, scrollView.bounds.size.height / 2 - 32);
    }
    
}



@end
