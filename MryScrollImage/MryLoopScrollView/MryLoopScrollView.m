//
//  MryScrollImageView.m
//  MryScrollImage
//
//  Created by mryun11 on 15/7/23.
//  Copyright (c) 2015年 mryun11. All rights reserved.
//

#import "MryLoopScrollView.h"

@interface MryLoopScrollView()

@property (nonatomic,strong) NSTimer *timer;

@end

@implementation MryLoopScrollView

- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        self.scrollView = scrollView;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.delegate = self;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 3, self.scrollView.frame.size.height);
        [self addSubview:self.scrollView];
        
        CGRect rect = self.bounds;
        rect.origin.y = rect.size.height - 30;
        rect.size.height = 30;
        UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:rect];
        pageControl.userInteractionEnabled = NO;
        pageControl.hidesForSinglePage = YES;
        self.pageControl = pageControl;
        [self addSubview:self.pageControl];
    }
    return self;
}

- (void)reloadData{
    
    self.currentPage = 0;
    self.totlePages = [self.dataSource numberOfPagesForLoopView:self];
    if (self.totlePages == 0) {
        return;
    }else if (self.totlePages == 1){
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        self.timer = nil;
    }else{
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 3, self.scrollView.frame.size.height);
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(goNextPage) userInfo:nil repeats:YES];
        self.timer = timer;
    }
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(handleTap)];
    [self addGestureRecognizer:singleTap];
    
    [self setUpViews];
    
    [self.pageControl setNumberOfPages:self.totlePages];
}

- (void)setUpViews{
    
    [self.pageControl setCurrentPage:self.currentPage];
    
    //从scrollView上移除所有的subview
    NSArray *subViews = [self.scrollView subviews];
    if([subViews count] != 0) {
        [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }

    [self getViewsArray];
    
    for (int i = 0; i < 3; i++) {
        UIView *view = self.viewsArray[i];
        view.userInteractionEnabled = YES;
        view.frame = CGRectOffset(view.frame, self.scrollView.frame.size.width * i, 0);
        [self.scrollView addSubview:view];
    }
    self.scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
}

- (void)getViewsArray{
    int prePage = [self validPageValue:self.currentPage - 1];
    int nextPage = [self validPageValue:self.currentPage + 1];
    
    [self.viewsArray removeAllObjects];
    
    [self.viewsArray addObject:[self.dataSource pageViewForLoopView:self atIndex:prePage]];
    [self.viewsArray addObject:[self.dataSource pageViewForLoopView:self atIndex:self.currentPage]];
    [self.viewsArray addObject:[self.dataSource pageViewForLoopView:self atIndex:nextPage]];
}

- (NSMutableArray *)viewsArray{
    if (!_viewsArray) {
        _viewsArray  =[NSMutableArray array];
    }
    return _viewsArray;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int x = scrollView.contentOffset.x;
    //往下翻一张
    if(x >= (2*scrollView.frame.size.width)) {
        self.currentPage = [self validPageValue:self.currentPage + 1];
        [self setUpViews];
    }
    
    //往上翻
    if(x <= 0) {
        self.currentPage = [self validPageValue:self.currentPage - 1];
        [self setUpViews];
    }

}

- (void)goNextPage{
    [self.scrollView setContentOffset:CGPointMake(2 * self.scrollView.frame.size.width, 0) animated:YES];
}

- (void)goPrePage{
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

//点击事件
- (void)handleTap{
    if ([self.delegate respondsToSelector:@selector(didClickLoopView:pageIndex:)]) {
        [self.delegate didClickLoopView:self pageIndex:self.currentPage];
    }
}

- (int)validPageValue:(NSInteger)value {
    
    if(value == -1) value = self.totlePages - 1;
    if(value == self.totlePages) value = 0;
    
    return (int)value;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
