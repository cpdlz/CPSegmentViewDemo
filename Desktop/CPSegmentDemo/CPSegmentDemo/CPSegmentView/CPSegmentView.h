//
//  CPSegmentView.h
//  CPSegmentDemo
//
//  Created by chenp on 16/9/27.
//  Copyright © 2016年 chenp. All rights reserved.
//

#define SCREEN_WIDTH                ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT               ([[UIScreen mainScreen] bounds].size.height)
#define SELF_VIEW_WIDTH             (self.view.frame.size.width)
#define SELF_VIEW_HEIGHT            (self.view.frame.size.height)
#define SELF_WIDTH                  (self.frame.size.width)
#define SELF_HEIGHT                 (self.frame.size.height)

#import <UIKit/UIKit.h>

@protocol CPSegmentViewDelegate <NSObject>

- (void)didSelectIndex:(NSInteger)index;

@end

@interface CPSegmentView : UIView <UIScrollViewDelegate>

@property (nonatomic, assign) BOOL animation;

@property (nonatomic, strong) NSArray *titleArray;//标题title
@property (nonatomic, strong) NSArray *showTableViewsArray;//每项对应的UITableView
@property (nonatomic, strong) NSArray *showControllersArray;//每项对应的UIViewController
@property (nonatomic, strong) UIColor *bgViewColor; // SegmentView背景颜色
@property (nonatomic, strong) UIColor *btnSeletedColor; // btn选中时颜色
@property (nonatomic, strong) UIColor *btnNormalColor; // btn未选中时颜色
@property (nonatomic, strong) UIColor *btnIndicatorColor; // btn选中时底部滑动条颜色
@property (nonatomic, strong) UIColor *indicatorBgViewColor; // 底部滑动条背景颜色
@property (nonatomic, assign) BOOL isShowIndicator; // 是否显示底部滑动条 默认Yes
@property (nonatomic, assign) CGFloat btnIndicatorHeight; //底部滑动条高度 默认为2

@property (nonatomic, assign)id<CPSegmentViewDelegate>delegate;

-(instancetype)initWithFrame:(CGRect)frame andTitleArray:(NSArray *)titleArray andShowControllerNameArray:(NSArray *)showControllersArray;

-(instancetype)initWithFrame:(CGRect)frame andTitleArray:(NSArray *)titleArray andShowTableViewsArray:(NSArray *)showTableViewsArray;

@end
