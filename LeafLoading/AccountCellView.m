//
//  AccountCellView.m
//  LeafLoading
//
//  Created by jinyulong on 2017/4/17.
//  Copyright © 2017年 云一程. All rights reserved.
//

#import "AccountCellView.h"

@implementation AccountCellView
- (IBAction)loginAction:(NSButton *)sender {
    [self.delegate loginBtnClicked:self.model];
}

- (IBAction)delBtn:(id)sender {
    [self.delegate delBtnClicked:self.model];
}

- (IBAction)modifyBtn:(id)sender {
    [self.delegate modifyBtnClicked:self.model];
}

- (void)setModel:(AccountModel *)model{
    _model = model;
    self.appStoreIdField.stringValue = model.appStoreId;
    self.appStoreNickField.stringValue = model.appStoreNickName.length > 0 ? model.appStoreNickName : @"";
}

@end
