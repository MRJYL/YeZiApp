//
//  Helper.m
//  LeafLoading
//
//  Created by jinyulong on 2017/4/10.
//  Copyright © 2017年 云一程. All rights reserved.
//

#import "Helper.h"

@implementation Helper

+ (NSString *)stringWithBundleSource:(NSString *)source{
    NSURL *path = [[NSBundle mainBundle] URLForResource:source withExtension:@"txt"];
    return [NSString stringWithContentsOfURL:path encoding:NSUTF8StringEncoding error:nil];
}

+ (void)uploadActiviteCode{
    AVQuery *activiteQuery = [AVQuery queryWithClassName:@"AppActivityValue"];
    [activiteQuery whereKey:@"SerialNumber" equalTo:[NSString serialNumber]];
    [activiteQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",error);
        }else{
            NSLog(@"%@",objects);
            if (Valid_Array(objects) && objects.count == 0) {
                AVObject *activiteObject = [AVObject objectWithClassName:@"AppActivityValue"];
                [activiteObject setObject:[NSString serialNumber] forKey:@"SerialNumber"];
                [activiteObject setObject:[NSString activiteCode] forKey:@"ActiviteCode"];
                NSLog(@"---------------------->%d",[activiteObject save]);
            }
        }
    }];
}

+ (void)getActiviteAccounts:(void(^)(NSArray <AccountModel*>*))accounts;{
    AVQuery *query = [AVQuery queryWithClassName:@"ASCount"];
    [query includeKey:@"count"];
    [query includeKey:@"password"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",error);
        }else{
            if (!accounts && !Valid_Array(objects)) {
                return ;
            }
            NSMutableArray *tmpAccounts = [@[] mutableCopy];
            NSLog(@"%@",objects);
            for (NSDictionary *account in objects) {
                [tmpAccounts addObject:[AccountModel AccountWithAppStoreId:account[@"appStoreId"] password:account[@"appStorePassword"] nickName:account[@"appStoreNickName"]]];
            }
            accounts(tmpAccounts);
        }
    }];
}

+ (BOOL)isPay{
    return [[[NSUserDefaults standardUserDefaults] valueForKey:@"activiteCode"] isEqualToString:[NSString activiteCode]];
}

@end
