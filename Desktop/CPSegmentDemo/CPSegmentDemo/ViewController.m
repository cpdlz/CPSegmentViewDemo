//
//  ViewController.m
//  CPSegmentDemo
//
//  Created by chenp on 16/9/27.
//  Copyright © 2016年 chenp. All rights reserved.
//

#import "ViewController.h"
#import "CPSegmentTableViewsController.h"
#import "CPSegmentViewController.h"

#define SCREEN_WIDTH   ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT  ([[UIScreen mainScreen] bounds].size.height)
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake((SCREEN_WIDTH - 150)/2, 80, 150, 30);
    [btn setTitle:@"TableViews" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.tag = 1;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake((SCREEN_WIDTH - 150)/2, 150, 150, 30);
    [btn1 setTitle:@"ViewControllers" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn1.tag = 2;
    [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];

}

- (void)btnClick:(UIButton *)sender{

    switch (sender.tag) {
        case 1:
            [self.navigationController pushViewController:[[CPSegmentTableViewsController alloc] init] animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:[[CPSegmentViewController alloc] init] animated:YES];
            break;
        default:
            break;
    }
}

@end
