//
//  NSView+YLCategory.m
//  LeafLoading
//
//  Created by jinyulong on 2017/4/10.
//  Copyright © 2017年 云一程. All rights reserved.
//

#import "NSView+YLCategory.h"

@implementation NSView (YLCategory)

- (CGFloat)width{
    return self.frame.size.width;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (void)addSubViews:(NSArray <NSView *>*)subViews{
    [subViews enumerateObjectsUsingBlock:^(NSView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSView class]]) {
            [self addSubview:obj];
        }
    }];
}

@end
