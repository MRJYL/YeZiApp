//
//  AppDelegate.m
//  LeafLoading
//
//  Created by 云一程 on 2017/4/10.
//  Copyright © 2017年 云一程. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)CleanActiviteCode:(id)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"activiteCode"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSAlert *alert = [[NSAlert alloc] init];
    alert.messageText = @"Clean Activite Code Success !";
    [alert beginSheetModalForWindow:[NSApplication sharedApplication].keyWindow completionHandler:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CleanActiviteCode" object:nil];
}

@end
