//
//  NoticeViewController.m
//  LeafLoading
//
//  Created by 云一程 on 2017/4/10.
//  Copyright © 2017年 云一程. All rights reserved.
//

#import "NoticeViewController.h"

@interface NoticeViewController ()

@property (unsafe_unretained) IBOutlet NSTextView *textView;

@end

@implementation NoticeViewController

- (void)viewWillAppear{
    [super viewWillAppear];
    NSLog(@"%@",self.view);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = [NSColor whiteColor].CGColor;
    NSDictionary *linkDic = @{@"购买链接":@"https://item.taobao.com/item.htm?id=547622555035",
                              @"官方介绍":@"https://itunes.apple.com/cn/app/navicat-premium/id434581944?mt=12",
                              @"团购链接":@"https://item.taobao.com/item.htm?id=548605791274",
                              @" 购买链接":@"https://item.taobao.com/item.htm?id=546337093398",
                              @" 购买链接 ":@"https://item.taobao.com/item.htm?spm=a1z10.1-c.w4004-11777036216.8.xuBMZE&id=544310173591",
                              @"yeziapp02":@"https://item.taobao.com/item.htm?id=548605791274",
                              @"hbmaoSS":@"http://ac-katpqdx3.clouddn.com/bc156dc650672effa020.jpg",
                              @"yeziapp.taobao.com":@"https://yeziapp.taobao.com/"};
    for (NSString *key in linkDic.allKeys) {
        [self.textView.textStorage setLink:linkDic[key] forString:key];
    }
}

@end
