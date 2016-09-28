//
//  CPSegmentViewController.m
//  CPSegmentDemo
//
//  Created by chenp on 16/9/28.
//  Copyright © 2016年 chenp. All rights reserved.
//

#import "CPSegmentViewController.h"
#import "CPSegmentView.h"
#import "MJRefresh.h"

#define CPCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define CPRandomColor_RGB CPCOLOR(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))


@interface CPSegmentViewController ()<CPSegmentViewDelegate>

@end

@implementation CPSegmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"TableViews";
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSArray *titleArr = @[@"控制器1",@"控制器2",@"控制器3",@"控制器4",@"控制器5",@"控制器6",@"控制器7",@"控制器8"];
    
    NSArray * controllerNameArray = @[@"OneViewController",@"TwoViewController",@"ThreeViewController",@"FourViewController",@"FiveViewController",@"SixViewController",@"SevenViewController",@"EightViewController"];
    
    CPSegmentView *segmentView = [[CPSegmentView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) andTitleArray:titleArr andShowControllerNameArray:controllerNameArray];
    segmentView.delegate = self;
    segmentView.btnSeletedColor = [UIColor cyanColor];
    segmentView.isShowIndicator = NO; // 底部滑动条
    [self.view addSubview:segmentView];
}

#pragma mark - CPSegmentViewDelegate

- (void)didSelectIndex:(NSInteger)index {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
