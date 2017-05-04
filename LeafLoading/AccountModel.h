//
//  AccountModel.h
//  LeafLoading
//
//  Created by jinyulong on 2017/4/17.
//  Copyright © 2017年 云一程. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountModel : NSObject

@property (nonatomic, copy) NSString *appStoreId;
@property (nonatomic, copy) NSString *appStorePassword;
@property (nonatomic, copy) NSString *appStoreNickName;

+ (instancetype)AccountWithAppStoreId:(NSString *)asId password:(NSString *)password nickName:(NSString *)nickName;
@end
