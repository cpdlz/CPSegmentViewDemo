//
//  OneViewController.m
//  CPSegmentDemo
//
//  Created by chenp on 16/9/28.
//  Copyright © 2016年 chenp. All rights reserved.
//

#import "OneViewController.h"

@interface OneViewController ()

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 30)];
    label.backgroundColor = [UIColor whiteColor];
    label.text = [NSString stringWithFormat:@"%@",NSStringFromClass([self class])];
    label.textColor = [UIColor redColor];
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
