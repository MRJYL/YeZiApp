//
//  AccountCellView.h
//  LeafLoading
//
//  Created by jinyulong on 2017/4/17.
//  Copyright © 2017年 云一程. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol AccountCellViewDelegate <NSObject>
@required
- (void)modifyBtnClicked:(AccountModel *)model;

- (void)delBtnClicked:(AccountModel *)model;

- (void)loginBtnClicked:(AccountModel *)model;

@end

@interface AccountCellView : NSTableCellView

@property (nonatomic, strong) AccountModel *model;

@property (nonatomic, weak) id<AccountCellViewDelegate> delegate;

@property (weak) IBOutlet NSTextField *appStoreIdField;

@property (weak) IBOutlet NSTextField *appStoreNickField;

@property (weak) IBOutlet NSButton *modifyBtn;

@property (weak) IBOutlet NSButton *delBtn;

@end
