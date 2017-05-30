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

+ (void)getCategories:(void (^)(NSArray <NSString *>*categories))categories{
    AVQuery *query = [AVQuery queryWithClassName:@"ASCategory"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",error.description);
        }else if(Valid_Array(objects)){
            AVObject *object = objects.firstObject;
            NSArray *category = [object objectForKey:@"category"];
            if (Valid_Array(category)) {
                categories(category);
            }else{
                categories([@[] copy]);
            }
        }else{
            categories([@[] copy]);
        }
    }];
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
            }else{
                AVObject *activiteObject = objects.firstObject;
                if (![[activiteObject objectForKey:@"ActiviteCode"] isEqualToString:[NSString activiteCode]]) {
                    NSLog(@"激活码已失效，更新激活码");
                    [activiteObject setObject:[NSString activiteCode] forKey:@"ActiviteCode"];
                    AVSaveOption *option = [AVSaveOption new];
                    option.query = activiteQuery;
                    [activiteObject saveWithOption:option error:nil];
                }
            }
        }
    }];
}

+ (void)getActiviteAccounts:(void(^)(NSArray <AccountModel*>*))accounts;{
    AVQuery *query = [AVQuery queryWithClassName:@"ASCount"];
    [query includeKey:@"appStoreNickName"];
    [query includeKey:@"appStorePassword"];
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
