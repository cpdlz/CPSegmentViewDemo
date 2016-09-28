//
//  CPSegmentView.m
//  CPSegmentDemo
//
//  Created by chenp on 16/9/27.
//  Copyright © 2016年 chenp. All rights reserved.
//

#import "CPSegmentView.h"
#import "UIView+Extension.h"

#define NAVIGATIONBAR_HEIGHT  64
#define CPCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define HEADERTABBAR_HEIGHT   44 // 头部SegmentView的高度
#define NUMBER 4  // 视图上需要直接显示item的个数

@interface CPSegmentView ()

@property (nonatomic,strong) UIView *titleView;
@property (nonatomic,strong) UIView *btnIndicator;
@property (nonatomic,  weak) UIButton *seletedBtn;
@property (nonatomic,strong) NSMutableArray *btnArr;
@property (nonatomic,assign) NSInteger tabBarLastIndex;
@property (nonatomic,strong) UIView *btnIndicatorBgView;
@property (nonatomic,strong) UIScrollView *normalBgView; //正常状态下label的背景
@property (nonatomic,strong) UIScrollView *segmentScrollView; //选中状态label的背景
@property (nonatomic,strong) UIScrollView *mainScrollView; //展示数据的scrollView
@property (nonatomic,assign) NSInteger itemCount; //item总数
@property (nonatomic,assign) NSInteger itemWidth; //item宽
@end

@implementation CPSegmentView

- (void)initializeData{
    _btnArr = [[NSMutableArray alloc] init];
    _animation = YES;//过度动画
    _isShowIndicator = YES;
    _bgViewColor = [UIColor whiteColor];
    _btnNormalColor = [UIColor blackColor];
    _btnSeletedColor = _btnIndicatorColor = [UIColor redColor];
    _indicatorBgViewColor = [UIColor orangeColor];//CPCOLOR(217, 217, 217);
    _btnIndicatorHeight = 2;
}

#pragma mark - setter
- (void)setIsShowIndicator:(BOOL)isShowIndicator {

    _isShowIndicator = isShowIndicator;
    if (!isShowIndicator) {
        _btnIndicator.hidden = YES;
        _btnIndicatorBgView.hidden = YES;
        [self setBtnIndicatorHeight:0];
    } else {
        _btnIndicator.hidden = NO;
        _btnIndicatorBgView.hidden = NO;
        [self setBtnIndicatorHeight:_btnIndicatorHeight];
    }
}

- (void)setBgViewColor:(UIColor *)bgViewColor {

    _bgViewColor = bgViewColor;
    _titleView.backgroundColor = bgViewColor;
}

- (void)setBtnNormalColor:(UIColor *)btnNormalColor {

    _btnNormalColor = btnNormalColor;
    for (UIButton *btn in _btnArr) {
        [btn setTitleColor:btnNormalColor forState:UIControlStateNormal];
    }
}

- (void)setBtnSeletedColor:(UIColor *)btnSeletedColor {

    _btnSeletedColor = btnSeletedColor;
    for (UIButton *btn in _btnArr) {
        [btn setTitleColor:btnSeletedColor forState:UIControlStateDisabled];
    }
}

- (void)setIndicatorBgViewColor:(UIColor *)indicatorBgViewColor {

    _indicatorBgViewColor = indicatorBgViewColor;
    _btnIndicatorBgView.backgroundColor = indicatorBgViewColor;
}

- (void)setBtnIndicatorHeight:(CGFloat)btnIndicatorHeight {

    _btnIndicatorHeight = btnIndicatorHeight;
    _btnIndicator.height = btnIndicatorHeight;
    _btnIndicatorBgView.height = btnIndicatorHeight;
    
    for (UIButton *btn in _btnArr) {
        btn.height = HEADERTABBAR_HEIGHT - btnIndicatorHeight;
    }
}

- (instancetype)initWithFrame:(CGRect)frame andTitleArray:(NSArray *)titleArray andShowControllerNameArray:(NSArray *)showControllersArray {

    self = [super initWithFrame:frame];
    if (self) {
        
        [self setFrame:frame];
        
        self.backgroundColor = [UIColor redColor];
        
        [self initializeData];
        
        _itemCount = titleArray.count;
        
        // 根据需要显示的个数平分宽度
        _itemWidth = _itemCount >= NUMBER ? self.width / NUMBER : self.width / _itemCount;
        
        [self addSubview:self.segmentScrollView];
        [_segmentScrollView addSubview:self.titleView];
        [self setupTitleBtnWith:titleArray];
        [self.titleView addSubview:self.btnIndicatorBgView];
        [self.titleView addSubview:self.btnIndicator];
        
        [self addSubview:self.mainScrollView];
        
        for (int i = 0; i < [showControllersArray count]; i++) {
            Class someClass = NSClassFromString(showControllersArray[i]);
            UIViewController * obj = [[someClass alloc] init];
            obj.view.frame = CGRectMake(i*self.width, 0, self.width, _mainScrollView.height);
            [_mainScrollView addSubview:obj.view];
        }
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame andTitleArray:(NSArray *)titleArray andShowTableViewsArray:(NSArray *)showTableViewsArray {

    self = [super initWithFrame:frame];
    if (self) {
        
        [self setFrame:frame];
        
        self.backgroundColor = [UIColor redColor];
        
        [self initializeData];
        
        _itemCount = titleArray.count;
        
        // 根据需要显示的个数平分宽度
        _itemWidth = _itemCount >= NUMBER ? self.width / NUMBER : self.width / _itemCount;
        
        [self addSubview:self.segmentScrollView];
        [_segmentScrollView addSubview:self.titleView];
        [self setupTitleBtnWith:titleArray];
        [self.titleView addSubview:self.btnIndicatorBgView];
        [self.titleView addSubview:self.btnIndicator];
        
        [self addSubview:self.mainScrollView];
        
        for (int i = 0; i < [showTableViewsArray count]; i++) {
            UITableView *tableView = showTableViewsArray[i];
            tableView.frame = CGRectMake(i*self.width, 0, self.width, _mainScrollView.height);
            [_mainScrollView addSubview:tableView];
        }   
    }
    return self;
}


//设置titleView按钮
-(void)setupTitleBtnWith:(NSArray *)titlesArray {
    
    CGFloat btnH = HEADERTABBAR_HEIGHT - 2;
    CGFloat btnY = 0;
    UIFont *font16 = [UIFont systemFontOfSize:16];

    for (NSInteger i = 0; i<_itemCount; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:titlesArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:_btnNormalColor forState:UIControlStateNormal];
        btn.titleLabel.font = font16;
        [btn setTitleColor:_btnSeletedColor forState:UIControlStateDisabled];
        CGFloat btnX = _itemWidth * i;
        btn.frame = CGRectMake(btnX, btnY, _itemWidth, btnH);
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        
        [self.titleView addSubview:btn];
        [_btnArr addObject:btn];
        
        //默认选中第一个按钮
        if (btn.tag == 0) {
            //self.hintLabel0.hidden = YES;
            btn.enabled = NO;
            self.seletedBtn = btn;
            //[btn.titleLabel sizeToFit];
            btn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
            self.btnIndicator.width = _itemWidth;
            self.btnIndicator.centerX = btn.centerX;
        }
    }
}

//按钮点击事件
-(void)btnClick:(UIButton *)btn {
    //按钮状态
    self.seletedBtn.enabled = YES;
    btn.enabled = NO;
    self.seletedBtn = btn;
    
    //指示器动画
    [UIView animateWithDuration:0.2 animations:^{
        self.btnIndicator.width = _itemWidth;//btn.titleLabel.width;
        self.btnIndicator.centerX = btn.centerX;
    }];
    
    //控制器view的滚动
    CGPoint offset = self.mainScrollView.contentOffset;
    offset.x = btn.tag * self.mainScrollView.width;
    [self.mainScrollView setContentOffset:offset animated:YES];
    
    _tabBarLastIndex = btn.tag;
    
    if ([_delegate respondsToSelector:@selector(didSelectIndex:)]) {
        [_delegate didSelectIndex:_tabBarLastIndex];
    }
    
    UIFont *systemFont = [UIFont systemFontOfSize:16];
    UIFont *boldSystemFont = [UIFont boldSystemFontOfSize:16];
    
    for (NSInteger i = 0; i < _itemCount; i++) {
        UIButton *tempBtn = _btnArr[i];
       if (i == btn.tag) {
            tempBtn.titleLabel.font = boldSystemFont;
        } else {
            tempBtn.titleLabel.font = systemFont;
        }
    }
}


#pragma  mark - UIScrollViewDelegate
//结束滚动时动画
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    if(scrollView == _mainScrollView){
        
        _tabBarLastIndex = scrollView.contentOffset.x / scrollView.width;
        
        NSInteger mainScrollViewOffSetCount = _mainScrollView.contentOffset.x / _mainScrollView.width;
        NSLog(@"mainScrollViewOffSetCount:%ld",mainScrollViewOffSetCount);
        NSInteger segmentScrollViewOffSetCount = _segmentScrollView.contentOffset.x / _itemWidth;
        NSLog(@"segmentScrollViewOffSetCount:%ld",segmentScrollViewOffSetCount);
        
        if (mainScrollViewOffSetCount < NUMBER) {
            
            [_segmentScrollView setContentOffset:CGPointMake(0, 0)];
        }
        else if (mainScrollViewOffSetCount - segmentScrollViewOffSetCount > (NUMBER-1) || mainScrollViewOffSetCount - segmentScrollViewOffSetCount < 0) {
            
            [_segmentScrollView setContentOffset:CGPointMake((mainScrollViewOffSetCount - (NUMBER-1))*_itemWidth, 0) animated:_animation];
        }
    }
}

//滚动减速时
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if(scrollView == _mainScrollView){
        [self scrollViewDidEndScrollingAnimation:scrollView];
        //点击titleView按钮
        _tabBarLastIndex = scrollView.contentOffset.x / scrollView.width;
        [self btnClick:self.titleView.subviews[_tabBarLastIndex]];
    }
}



// 根据给定的title和字体，计算title所占矩形高度
- (CGSize)calculateSizeWithTitle:(NSString*)title font:(UIFont*)font
{
    NSMutableDictionary* fontAttr = [NSMutableDictionary dictionary];
    fontAttr[NSFontAttributeName] = font;
    return [title sizeWithAttributes:fontAttr];
}


- (UIScrollView *)segmentScrollView {
    if (_segmentScrollView == nil) {
        _segmentScrollView = [[UIScrollView alloc]init];
        _segmentScrollView.backgroundColor = [UIColor whiteColor];
        _segmentScrollView.frame = CGRectMake(0, 0, self.width, HEADERTABBAR_HEIGHT);
        [_segmentScrollView setShowsVerticalScrollIndicator:NO];
        [_segmentScrollView setShowsHorizontalScrollIndicator:NO];
        _segmentScrollView.contentSize = CGSizeMake(_itemWidth * _itemCount, 0);
    }
    return _segmentScrollView;
}


- (UIView *)titleView{
    if (_titleView == nil) {
        _titleView = [[UIView alloc]init];
        _titleView.frame = CGRectMake(0, 0, _itemWidth * _itemCount, HEADERTABBAR_HEIGHT);
        _titleView.backgroundColor = [UIColor whiteColor];
    }
    return _titleView;
}



- (UIScrollView *)mainScrollView {
    if (_mainScrollView == nil) {
        _mainScrollView = [[UIScrollView alloc]init];
        _mainScrollView.frame = CGRectMake(0, HEADERTABBAR_HEIGHT, SCREEN_WIDTH, SELF_HEIGHT - HEADERTABBAR_HEIGHT);
        _mainScrollView.delegate = self;
        _mainScrollView.backgroundColor = [UIColor whiteColor];;
        _mainScrollView.pagingEnabled = YES;//分页
        _mainScrollView.contentSize = CGSizeMake(self.width * _itemCount, 0);
    }
    return _mainScrollView;
}


- (UIView *)btnIndicatorBgView{
    if (_btnIndicatorBgView == nil) {
        _btnIndicatorBgView = [[UIView alloc]init];
        _btnIndicatorBgView.backgroundColor = _indicatorBgViewColor;
        _btnIndicatorBgView.frame = CGRectMake(0, self.titleView.height-_btnIndicatorHeight, self.titleView.width, _btnIndicatorHeight);
    }
    return _btnIndicatorBgView;
}

- (UIView *)btnIndicator{
    if (_btnIndicator == nil) {
        _btnIndicator = [[UIView alloc]init];
        _btnIndicator.backgroundColor = _btnIndicatorColor;
        _btnIndicator.height = _btnIndicatorHeight;
        _btnIndicator.y = self.titleView.height - _btnIndicator.height;
    }
    return _btnIndicator;
}





@end
