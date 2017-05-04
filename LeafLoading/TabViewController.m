//
//  TabViewController.m
//  LeafLoading
//
//  Created by 云一程 on 2017/4/10.
//  Copyright © 2017年 云一程. All rights reserved.
//

#import "TabViewController.h"

@interface TabViewController ()<NSTabViewDelegate>

@end

@implementation TabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = [NSColor whiteColor].CGColor;
    self.tabView.wantsLayer = YES;
    self.tabView.layer.backgroundColor = [NSColor whiteColor].CGColor;
    [AVOSCloud setApplicationId:@"6m9RFU6ieN2eKyKC44m73Yqa-gzGzoHsz" clientKey:@"iCYQTUdr0bXCS5Cf1LUrYCBo"];
    [AVOSCloud setAllLogsEnabled:NO];
}

- (void)tabView:(NSTabView *)tabView didSelectTabViewItem:(NSTabViewItem *)tabViewItem{
    [super tabView:tabView didSelectTabViewItem:tabViewItem];
}

@end
