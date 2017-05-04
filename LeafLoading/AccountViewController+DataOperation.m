//
//  AccountViewController+DataOperation.m
//  LeafLoading
//
//  Created by jinyulong on 2017/4/17.
//  Copyright © 2017年 云一程. All rights reserved.
//

#import "AccountViewController+DataOperation.h"

@implementation AccountViewController (DataOperation)

- (NSMutableArray <AccountModel *>*)getCustomerAccounts{
    NSMutableArray *accountArray = [@[] mutableCopy];
    NSString *jsonString = [[NSUserDefaults standardUserDefaults] objectForKey:kCustomerAccounts];
    if (!Valid_String(jsonString)) {
        return accountArray;
    }
    id obj = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    if (!Valid_Array(obj)) {
        return accountArray;
    }
    for (NSDictionary *dic in obj) {
        if (!Valid_Dictionary(dic)) {
            continue;
        }
        AccountModel *model = [AccountModel new];
        model.appStoreId = dic[@"appStoreId"];
        model.appStorePassword = dic[@"appStorePassword"];
        model.appStoreNickName = dic[@"appStoreNickName"];
        [accountArray addObject:model];
    }
    return accountArray;
}

- (void)saveCustomerAccounts:(NSMutableArray <AccountModel *>*)accounts{
    NSMutableArray *accountsCache = [@[] mutableCopy];
    for (AccountModel *model in accounts) {
        if (![model isKindOfClass:[AccountModel class]]) {
            continue;
        }
        NSDictionary *account = @{@"appStoreId":model.appStoreId,@"appStorePassword":model.appStorePassword,@"appStoreNickName":model.appStoreNickName};
        [accountsCache addObject:account];
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:accountsCache options:NSJSONWritingPrettyPrinted error:nil];

    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [[NSUserDefaults standardUserDefaults] setObject:jsonString forKey:kCustomerAccounts];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
