//
//  LineAI-V2.m
//  Boxes
//
//  Created by Andrew on 4/21/13.
//  Copyright (c) 2013 ATFinke Productions Incorporated. All rights reserved.
//

#import "LineAI-V2.h"

@implementation LineAI_V2

+ (LineAI_V2 *) sharedInstance {
    static LineAI_V2 *sharedHelper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedHelper = [[LineAI_V2 alloc] init];
    });
    
    return sharedHelper;
}

-(id)init {
    return self;
}



-(NSString *) lineForSquares:(NSMutableArray *)squares{
    
    NSMutableArray * lines = [[NSMutableArray alloc]init];
    
    for (NSMutableArray * square in squares) {
        if (square.count == 1) {
            return square[0];
        }
        for (NSString * line in square) {
            [lines addObject:line];
        }
    }
    
    for (int x = 0; x < [lines count]; x++) {
        int randInt = (arc4random() % ([lines count] - x)) + x;
        [lines exchangeObjectAtIndex:x withObjectAtIndex:randInt];
    }
    
    for (NSString * line in lines) {
        for (NSMutableArray * square in squares) {
            for (NSString * object in square) {
                if ([object isEqual:line]) {
                    if (square.count>2) {
                        if ([self checkLine:line forOtherSquares:squares]) {
                            return line;
                        }
                    }
                }
            }
        }
    }
    
    if (lines.count != 0) {
        NSUInteger index = arc4random() % [lines count];
        return lines[index];
    }
    
    return @"GAME";
}

-(BOOL) checkLine:(NSString *) line forOtherSquares:(NSMutableArray *) squares{
    
    NSMutableArray * squaresWithLine = [[NSMutableArray alloc]init];
    
    for (NSMutableArray * square in squares) {
        for (NSString * object in square) {
            if ([object isEqual:line]) {
                [squaresWithLine addObject:square];
            }
        }
    }
    for (NSMutableArray * square in squaresWithLine) {
        if (square.count == 2) {
            return NO;
        }
    }
    return YES;
}





@end
