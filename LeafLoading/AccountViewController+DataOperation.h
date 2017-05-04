//
//  AccountViewController+DataOperation.h
//  LeafLoading
//
//  Created by jinyulong on 2017/4/17.
//  Copyright © 2017年 云一程. All rights reserved.
//

#import "AccountViewController.h"

@interface AccountViewController (DataOperation)

- (NSMutableArray <AccountModel *>*)getCustomerAccounts;

- (void)saveCustomerAccounts:(NSMutableArray <AccountModel *>*)accounts;

@end
