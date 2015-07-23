//
//  ViewController.m
//  MryScrollImage
//
//  Created by mryun11 on 15/7/23.
//  Copyright (c) 2015年 mryun11. All rights reserved.
//

#import "ViewController.h"
#import "MryLoopScrollView.h"

@interface ViewController ()<MryLoopScrollViewDelegate,MryLoopScrollViewDataSource>

@property (nonatomic,weak) MryLoopScrollView *loopView;

@property (nonatomic,strong) NSMutableArray *imageArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MryLoopScrollView *loopView = [[MryLoopScrollView alloc]initWithFrame:self.view.bounds];
    loopView.delegate = self;
    loopView.dataSource = self;
    self.loopView = loopView;
    [self.view addSubview:loopView];
    
    [loopView reloadData];
}

- (NSInteger)numberOfPagesForLoopView:(MryLoopScrollView *)loopView{
    return self.imageArray.count;
}

- (UIView *)pageViewForLoopView:(MryLoopScrollView *)loopView atIndex:(NSInteger)pageIndex{
    UIImageView *view = [[UIImageView alloc]initWithFrame:loopView.bounds];
    view.image = [UIImage imageNamed:self.imageArray[pageIndex]];
    [view setContentMode:UIViewContentModeScaleToFill];
    return view;
}

- (void)didClickLoopView:(MryLoopScrollView *)loopView pageIndex:(NSInteger)pageIndex{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [NSMutableArray arrayWithObjects:@"pic1",@"pic2",@"pic3",@"pic4",@"pic5", nil];
    }
    return _imageArray;
}

@end
