//
//  NSMutableAttributedString+YLCategory.m
//  LeafLoading
//
//  Created by jinyulong on 2017/4/14.
//  Copyright © 2017年 云一程. All rights reserved.
//

#import "NSMutableAttributedString+YLCategory.h"

@implementation NSMutableAttributedString (YLCategory)

- (void)setLink:(NSString *)link forRange:(NSRange)range{
    [self addAttribute:NSLinkAttributeName value:link range:range];
}
- (void)setLink:(NSString *)link forString:(NSString *)string{
    NSRange range = [self.string rangeOfString:string];
//    NSAssert(range.location == NSNotFound, @"文字不存在");
    [self setLink:link forRange:range];
}

@end
