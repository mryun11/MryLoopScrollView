//
//  MryScrollImageView.h
//  MryScrollImage
//
//  Created by mryun11 on 15/7/23.
//  Copyright (c) 2015年 mryun11. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MryLoopScrollView;

@protocol MryLoopScrollViewDataSource <NSObject>

- (NSInteger)numberOfPagesForLoopView:(MryLoopScrollView *)loopView;
- (UIView *)pageViewForLoopView:(MryLoopScrollView *)loopView atIndex:(NSInteger)pageIndex;

@end

@protocol MryLoopScrollViewDelegate <NSObject>

@optional
- (void)didClickLoopView:(MryLoopScrollView *)loopView pageIndex:(NSInteger)pageIndex;

@end

@interface MryLoopScrollView : UIView <UIScrollViewDelegate>

@property (nonatomic,weak) id<MryLoopScrollViewDataSource> dataSource;
@property (nonatomic,weak) id<MryLoopScrollViewDelegate> delegate;

- (void)reloadData;

@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic,weak) UIPageControl *pageControl;

@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,assign) NSInteger totlePages;
@property (nonatomic,strong) NSMutableArray *viewsArray;

- (void)goNextPage;
- (void)goPrePage;

@end
