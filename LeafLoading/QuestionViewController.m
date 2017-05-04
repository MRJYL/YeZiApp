//
//  QuestionViewController.m
//  LeafLoading
//
//  Created by 云一程 on 2017/4/10.
//  Copyright © 2017年 云一程. All rights reserved.
//

#import "QuestionViewController.h"

@interface QuestionViewController ()

@end

@implementation QuestionViewController

- (void)viewWillAppear{
    [super viewWillAppear];
    NSLog(@"%@",self.view);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = [NSColor whiteColor].CGColor;
}

@end
