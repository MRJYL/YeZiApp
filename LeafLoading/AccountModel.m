//
//  AccountModel.m
//  LeafLoading
//
//  Created by jinyulong on 2017/4/17.
//  Copyright © 2017年 云一程. All rights reserved.
//

#import "AccountModel.h"

@implementation AccountModel

+ (instancetype)AccountWithAppStoreId:(NSString *)asId password:(NSString *)password nickName:(NSString *)nickName{
    AccountModel *account = [AccountModel new];
    account.appStoreId = Valid_String(asId) ? asId : @"";
    account.appStorePassword = Valid_String(password) ? password : @"";
    account.appStoreNickName = Valid_String(nickName) ? nickName : @"";
    return  account;
}

@end
