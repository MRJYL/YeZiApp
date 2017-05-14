//
//  NSString+YLCategory.m
//  LeafLoading
//
//  Created by jinyulong on 2017/4/20.
//  Copyright © 2017年 云一程. All rights reserved.
//

#import "NSString+YLCategory.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (YLCategory)

- (NSString *)MD5_16{
    const char *cStr =[self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

//获取序列号
+ (NSString *)serialNumber
{
    io_service_t    platformExpert = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("IOPlatformExpertDevice"));
    CFStringRef serialNumberAsCFString = NULL;
    
    if (platformExpert) {
        serialNumberAsCFString = IORegistryEntryCreateCFProperty(platformExpert, CFSTR(kIOPlatformSerialNumberKey), kCFAllocatorDefault, 0);
        IOObjectRelease(platformExpert);
    }
    
    NSString *serialNumberAsNSString = nil;
    if (serialNumberAsCFString) {
        serialNumberAsNSString = [NSString stringWithString:(__bridge NSString *)serialNumberAsCFString];
        CFRelease(serialNumberAsCFString);
    }
    return serialNumberAsNSString;
}

+ (NSString *)activiteCode{
    NSString *activiteCode = [NSString serialNumber];
    activiteCode = [activiteCode MD5_16];
    activiteCode = [[activiteCode stringByAppendingString:@"LeafLoading"] MD5_16];
    return activiteCode;
}

@end
