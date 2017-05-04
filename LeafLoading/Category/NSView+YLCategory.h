//
//  NSView+YLCategory.h
//  LeafLoading
//
//  Created by jinyulong on 2017/4/10.
//  Copyright © 2017年 云一程. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSView (YLCategory)

- (CGFloat)width;

- (CGFloat)height;

- (void)addSubViews:(NSArray <NSView *>*)subViews;

@end
