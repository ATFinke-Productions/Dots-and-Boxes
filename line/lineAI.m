//
//  lineAI.m
//  dot
//
//  Created by Andrew on 4/5/13.
//  Copyright (c) 2013 Andrew. All rights reserved.
//

#import "lineAI.h"

@implementation lineAI

+ (lineAI *) sharedInstance {
    static lineAI *sharedHelper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedHelper = [[lineAI alloc] init];
    });
    
    return sharedHelper;
}

-(id)init {
    if ((self = [super init])) {
    }
    return self;
}



-(NSString *)moveForSpaceWithSquares:(NSMutableArray *)squares{
    
    [Flurry logEvent:@"LineAI Move"];
    
    NSMutableArray * bestLines = [[NSMutableArray alloc]init];
    NSMutableArray * goodLines = [[NSMutableArray alloc]init];
    NSMutableArray * allLines = [[NSMutableArray alloc]init];
    
    for (NSMutableArray * individualSquare in squares) {
        if ([individualSquare count]==1) {
            for (NSString * line in individualSquare) {
                [bestLines addObject:line];
            }
        }
    }
    for (NSMutableArray * individualSquare in squares) {
        if ([individualSquare count]>2) {
            for (NSString * line in individualSquare) {
                [goodLines addObject:line];
            }
        }
    }
    for (NSMutableArray * individualSquare in squares) {
        for (NSString * line in individualSquare) {
            [allLines addObject:line];
        }
    }
    
    for (int x = 0; x < [bestLines count]; x++) {
        int randInt = (arc4random() % ([bestLines count] - x)) + x;
        [bestLines exchangeObjectAtIndex:x withObjectAtIndex:randInt];
    }
    for (int x = 0; x < [goodLines count]; x++) {
        int randInt = (arc4random() % ([goodLines count] - x)) + x;
        [goodLines exchangeObjectAtIndex:x withObjectAtIndex:randInt];
    }
    for (int x = 0; x < [allLines count]; x++) {
        int randInt = (arc4random() % ([allLines count] - x)) + x;
        [allLines exchangeObjectAtIndex:x withObjectAtIndex:randInt];
    }
    
    
    
    
    ///
  
    for (int check = 0; check < [bestLines count] ;check++) {
        NSString * object = [NSString stringWithFormat:@"%@",bestLines[check]];
        for (NSMutableArray * individualSquare in squares) {
            for (NSString * objectsInSquare in individualSquare) {
                if ([objectsInSquare isEqual:object]) {
                    if ([individualSquare count] == 1) {
                        return object;
                    }
                }
            }
        }
    }
    
    

    
    
    
    
    ///
    
    for (int check = 0; check < [goodLines count] ;check++) {
        NSString * object = [NSString stringWithFormat:@"%@",goodLines[check]];
        BOOL CP1 = NO;
        BOOL CP2 = NO;
        for (NSMutableArray * individualSquare in squares) {
            for (int obj = 0; obj < [individualSquare count]; obj++) {
                if ([individualSquare[arc4random() % [individualSquare count]] isEqual:object]) {
                    if ([individualSquare count]> 3) {
                        if (!CP1) {
                            CP1 = YES;
                        }
                        else if (!CP2){
                            CP2 = YES;
                            return object;
                        }
                    }
                }
            }
        }
    }
    
    
    for (int check = 0; check < [goodLines count] ;check++) {
        NSString * object = [NSString stringWithFormat:@"%@",goodLines[check]];
        BOOL CP1 = NO;
        for (NSMutableArray * individualSquare in squares) {
            for (NSString * objectsInSquare in individualSquare) {
                if ([objectsInSquare isEqual:object]) {
                    if ([individualSquare count]> 3) {
                        if (!CP1) {
                            CP1 = YES;
                            return object;
                        }
                    }
                }
            }
        }
    }
    
    ///
    
    for (int check = 0; check < [goodLines count] ;check++) {
        NSString * object = [NSString stringWithFormat:@"%@",goodLines[check]];
        BOOL CP1 = NO;
        BOOL CP2 = NO;
        for (NSMutableArray * individualSquare in squares) {
            for (NSString * objectsInSquare in individualSquare) {
                if ([objectsInSquare isEqual:object]) {
                    if ([individualSquare count]> 2) {
                        if (!CP1) {
                            CP1 = YES;
                        }
                        else if (!CP2){
                            CP2 = YES;
                            return object;
                        }
                    }
                }
            }
        }
    }
    for (int check = 0; check < [goodLines count] ;check++) {
        NSString * object = [NSString stringWithFormat:@"%@",goodLines[check]];
        BOOL CP1 = NO;
        for (NSMutableArray * individualSquare in squares) {
            for (NSString * objectsInSquare in individualSquare) {
                if ([objectsInSquare isEqual:object]) {
                    if ([individualSquare count]> 2) {
                        if (!CP1) {
                            CP1 = YES;
                            return object;
                        }
                    }
                }
            }
        }
    }
    
    ///
    
    for (int check = 0; check < [allLines count] ;check++) {
        NSString * object = [NSString stringWithFormat:@"%@",allLines[check]];
        for (NSMutableArray * individualSquare in squares) {
            for (NSString * objectsInSquare in individualSquare) {
                if ([objectsInSquare isEqual:object]) {
                    if ([individualSquare count]> 3) {
                        return object;
                    }
                }
            }
        }
    }

    for (int check = 0; check < [allLines count] ;check++) {
        NSString * object = [NSString stringWithFormat:@"%@",allLines[check]];
        for (NSMutableArray * individualSquare in squares) {
            for (NSString * objectsInSquare in individualSquare) {
                if ([objectsInSquare isEqual:object]) {
                    if ([individualSquare count]> 2) {
                        return object;
                    }
                }
            }
        }
    }
    if ([allLines count]>0) {
        return allLines[0];
    }
    return @"GAME";
}

@end
