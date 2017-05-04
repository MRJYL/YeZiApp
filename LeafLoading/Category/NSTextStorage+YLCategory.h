//
//  NSTextStorage+YLCategory.h
//  LeafLoading
//
//  Created by jinyulong on 2017/4/14.
//  Copyright © 2017年 云一程. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSTextStorage (YLCategory)

- (void)setLink:(NSString *)link forRange:(NSRange)range;
- (void)setLink:(NSString *)link forString:(NSString *)string;

@end
