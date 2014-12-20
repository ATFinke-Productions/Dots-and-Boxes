//
//  LocalMatch.h
//  Boxes
//
//  Created by Andrew on 4/19/13.
//  Copyright (c) 2013 Andrew. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LocalMatch;
@protocol LocalMatchDelegate
//-(void)turnHasHappened;
@end

@interface LocalMatch : NSObject

@property (nonatomic, weak) IBOutlet id <LocalMatchDelegate> delegate;
@property (strong) NSString * currentMatchName;
@property (nonatomic) int currentMatchID;
@property (nonatomic) int currentParticipantIndex;
@property (strong) NSMutableArray * participants;
@property (strong) NSMutableArray * indexOfAIParticepents;
@property (strong) NSMutableArray * linesToAddToGrid;
@property (strong) NSMutableArray * squaresForPlayer1;
@property (strong) NSMutableArray * squaresForPlayer2;
@property (strong) NSMutableArray * squaresForPlayer3;
@property (strong) NSMutableArray * squaresForPlayer4;

@property (strong) NSMutableArray * lastLinesToAddToGrid;
@property (strong) NSMutableArray * lastSquaresForPlayer1;
@property (strong) NSMutableArray * lastSquaresForPlayer2;
@property (strong) NSMutableArray * lastSquaresForPlayer3;
@property (strong) NSMutableArray * lastSquaresForPlayer4;

+ (LocalMatch *)sharedInstance;
- (void) setInitalMatch;
- (void) setArraysToPreviousTurn;
- (void) advanceTurnForGameOver:(BOOL)done;
- (void) setNewMatchID:(NSString *)stringMatchID;
- (int) playerCountForMatchWithID:(NSString *)stringMatchID;
- (NSString *) matchNameForID:(NSString *)stringMatchID;
- (NSString *) participantsForMatchWithID:(NSString *)stringMatchID;
- (NSString *) participantsForMatchWithID:(NSString *)stringMatchID atIndex:(int)index;
@end
