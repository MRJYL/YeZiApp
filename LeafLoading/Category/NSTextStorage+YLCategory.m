//
//  NSTextStorage+YLCategory.m
//  LeafLoading
//
//  Created by jinyulong on 2017/4/14.
//  Copyright © 2017年 云一程. All rights reserved.
//

#import "NSTextStorage+YLCategory.h"

@implementation NSTextStorage (YLCategory)

- (void)setLink:(NSString *)link forRange:(NSRange)range{
    [self addAttribute:NSLinkAttributeName value:link range:range];
}
- (void)setLink:(NSString *)link forString:(NSString *)string{
    NSRange range = [self.string rangeOfString:string];
    [self setLink:link forRange:range];
}

@end
