//
//  ViewController.m
//  LeafLoading
//
//  Created by jinyulong on 2017/4/10.
//  Copyright © 2017年 云一程. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSSegmentedControl *segment;
@property (nonatomic, strong) NSTabView *tabView;
@property (nonatomic, strong) NoticeView *noticeView;
@property (nonatomic, strong) AccountView *accountView;
@property (nonatomic, strong) QuestionView *questionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.backgroundColor = [NSColor whiteColor].CGColor;
    [self.view addSubview:self.segment];
    [self.view addSubview:self.noticeView];
    [self.view addSubview:self.accountView];
    [self.view addSubview:self.questionView];
}

- (void)segmentAction:(NSSegmentedControl *)segment{
    NSInteger selectedIndex = segment.selectedSegment;
    NSLog(@"%ld",selectedIndex);
}


- (NSSegmentedControl *)segment{
    if (!_segment) {
        _segment = [NSSegmentedControl segmentedControlWithLabels:@[@"公告",@"账号",@"常见问题"] trackingMode:NSSegmentSwitchTrackingSelectOne target:self action:@selector(segmentAction:)];
        _segment.frame = CGRectMake(30, 50, kFullScreenSize.width - 60, 44);
        for (int i = 0; i < _segment.segmentCount; i++) {
            [_segment setWidth:(kFullScreenSize.width - 60) / 3 forSegment:i];
        }
        [_segment setSelectedSegment:0];
    }
    return _segment;
}

- (NSTabView *)tabView{
    if (!_tabView) {
        _tabView = [[NSTabView alloc] initWithFrame:CGRectMake(0, 50, kFullScreenSize.width, kFullScreenSize.height - 50)];
        
    }
    return _tabView;
}

- (NoticeView *)noticeView{
    if (!_noticeView) {
        _noticeView = [[NoticeView alloc] init];
    }
    return _noticeView;
}

- (AccountView *)accountView{
    if (!_accountView) {
        _accountView = [[AccountView alloc] init];
    }
    return _accountView;
}

- (QuestionView *)questionView{
    if (!_questionView) {
        _questionView = [[QuestionView alloc] init];
    }
    return _questionView;
}

@end
