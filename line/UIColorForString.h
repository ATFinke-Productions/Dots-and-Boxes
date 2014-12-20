//
//  UIColorForString.h
//  dot
//
//  Created by Andrew on 4/6/13.
//  Copyright (c) 2013 Andrew. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIColorForString : NSObject

+ (UIColorForString *)sharedInstance;
- (UIColor *)colorForString:(NSString *)name;
- (UIImage *)imageForColor:(UIColor *)color forType:(NSString *)type;
- (UIImage *)imageForColorWithString:(NSString *)string forType:(NSString *)type;
@end
