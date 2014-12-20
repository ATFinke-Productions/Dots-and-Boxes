//
//  UIColorForString.m
//  dot
//
//  Created by Andrew on 4/6/13.
//  Copyright (c) 2013 Andrew. All rights reserved.
//

#import "UIColorForString.h"

@implementation UIColorForString


+ (UIColorForString *) sharedInstance {
    static UIColorForString *sharedHelper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedHelper = [[UIColorForString alloc] init];
    });
    
    return sharedHelper;
}

-(id)init {
    if ((self = [super init])) {
    }
    return self;
}

- (UIImage *)imageForColorWithString:(NSString *)string forType:(NSString *)type{
    UIColor * color = [self colorForString:string];

    CGRect rect;
    if ([type isEqual:@"horizontial"]) {
        rect = CGRectMake(0.0f, 0.0f, 30.0f, 3.0f);
    }
    else if ([type isEqual:@"vertical"]){
        rect = CGRectMake(0.0f, 0.0f, 3.0f, 30.0f);
    }
    else {
        rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    }
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
-(UIImage *)imageForColor:(UIColor *)color forType:(NSString *)type{
    CGRect rect;
    if ([type isEqual:@"horizontial"]) {
        rect = CGRectMake(0.0f, 0.0f, 30.0f, 3.0f);
    }
    else if ([type isEqual:@"vertical"]){
        rect = CGRectMake(0.0f, 0.0f, 3.0f, 30.0f);
    }
    else {
        rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    }
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
-(UIColor *)colorForString:(NSString *)name{
    if ([name isEqual:@"Black"]) {
        return [UIColor blackColor];
    }
    else if ([name isEqual:@"Blue"]){
        return [UIColor blueColor];
    }
    else if ([name isEqual:@"Brown"]){
        return [UIColor brownColor];
    }
    else if ([name isEqual:@"Cyan"]){
        return [UIColor cyanColor];
    }
    else if ([name isEqual:@"Light Gray"]){
        return [UIColor lightGrayColor];
    }
    else if ([name isEqual:@"White"]){
        return [UIColor whiteColor];
    }
    else if ([name isEqual:@"Red"]){
        return [UIColor redColor];
    }
    else if ([name isEqual:@"Green"]){
        return [UIColor greenColor];
    }
    else if ([name isEqual:@"Yellow"]){
        return [UIColor yellowColor];
    }
    else if ([name isEqual:@"Magenta"]){
        return [UIColor magentaColor];
    }
    else if ([name isEqual:@"Orange"]){
        return [UIColor orangeColor];
    }
    else if ([name isEqual:@"Purple"]){
        return [UIColor purpleColor];
    }
    else if ([name isEqual:@"Clear"]){
        return [UIColor clearColor];
    }
    else if ([name isEqual:@"Dark Gray"]){
        return [UIColor darkGrayColor];
    }
    else if ([name isEqual:@"Gray"]){
        return [UIColor grayColor];
    }
    return nil;
}


@end
