//
//  Helper.h
//  LeafLoading
//
//  Created by jinyulong on 2017/4/10.
//  Copyright © 2017年 云一程. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kCustomerAccounts @"kCustomerAccounts"
#define Valid_Dictionary(dic) (dic && [dic isKindOfClass:[NSDictionary class]])
#define Valid_Array(array) (array && [array isKindOfClass:[NSArray class]])
#define Valid_Number(number) (number && [number isKindOfClass:[NSNumber class]])
#define Valid_String(string) (string && [string isKindOfClass:[NSString class]] && [string length] > 0)

@interface Helper : NSObject

+ (NSString *)stringWithBundleSource:(NSString *)source;

+ (void)getCategories:(void(^)(NSArray <NSString*>*categories))categories;

+ (void)uploadActiviteCode;

+ (void)getActiviteAccounts:(void(^)(NSArray <AccountModel*>*))accounts;

+ (BOOL)isPay;

@end
