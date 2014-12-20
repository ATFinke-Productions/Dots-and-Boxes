//
//  LocalMatch.m
//  Boxes
//
//  Created by Andrew on 4/19/13.
//  Copyright (c) 2013 Andrew. All rights reserved.
//

#import "LocalMatch.h"

@implementation LocalMatch

+ (LocalMatch *) sharedInstance {
    static LocalMatch *sharedHelper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedHelper = [[LocalMatch alloc] init];
    });
    
    return sharedHelper;
}

-(id)init {
    if ((self = [super init])) {
    }
    return self;
}

-(void) setArraysToPreviousTurn {
    
    [_linesToAddToGrid removeAllObjects];
    [_squaresForPlayer1 removeAllObjects];
    [_squaresForPlayer2 removeAllObjects];
    [_squaresForPlayer3 removeAllObjects];
    [_squaresForPlayer4 removeAllObjects];
    
    for (id object in _lastLinesToAddToGrid) {
        [_linesToAddToGrid addObject:object];
    }
    for (id object in _lastSquaresForPlayer1) {
        [_squaresForPlayer1 addObject:object];
    }
    for (id object in _lastSquaresForPlayer2) {
        [_squaresForPlayer2 addObject:object];
    }
    for (id object in _lastSquaresForPlayer3) {
        [_squaresForPlayer3 addObject:object];
    }
    for (id object in _lastSquaresForPlayer4) {
        [_squaresForPlayer4 addObject:object];
    }
}

- (void) advanceTurnForGameOver:(BOOL)done{
    
    _currentParticipantIndex ++;
    if (_currentParticipantIndex>[_participants count]-1) {
        _currentParticipantIndex = 0;
    }
    
    [_lastLinesToAddToGrid removeAllObjects];
    [_lastSquaresForPlayer1 removeAllObjects];
    [_lastSquaresForPlayer2 removeAllObjects];
    [_lastSquaresForPlayer3 removeAllObjects];
    [_lastSquaresForPlayer4 removeAllObjects];
    for (id object in _linesToAddToGrid) {
        [_lastLinesToAddToGrid addObject:object];
    }
    for (id object in _squaresForPlayer1) {
        [_lastSquaresForPlayer1 addObject:object];
    }
    for (id object in _squaresForPlayer2) {
        [_lastSquaresForPlayer2 addObject:object];
    }
    for (id object in _squaresForPlayer3) {
        [_lastSquaresForPlayer3 addObject:object];
    }
    for (id object in _squaresForPlayer4) {
        [_lastSquaresForPlayer4 addObject:object];
    }
    
    NSString * currentParticipantIndexString = [NSString stringWithFormat:@"%d",_currentParticipantIndex];
 
    NSArray * objectsForDictionary = [NSArray arrayWithObjects:_currentMatchName,currentParticipantIndexString, _participants, _indexOfAIParticepents, _linesToAddToGrid, _squaresForPlayer1, _squaresForPlayer2, _squaresForPlayer3, _squaresForPlayer4, nil];
    
    NSArray * keysForDictionary = [NSArray arrayWithObjects:@"MatchName",@"currentPlayerIndex", @"participants",@"indexOfAIParticpents", @"linesToAddToGrid", @"squaresForPlayer1", @"squaresForPlayer2", @"squaresForPlayer3", @"squaresForPlayer4", nil];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjects:objectsForDictionary forKeys:keysForDictionary];
    
    [[NSUserDefaults standardUserDefaults] setValue:dict forKey:[NSString stringWithFormat:@"%dLocalMatch",_currentMatchID]];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (void) setNewMatchID:(NSString *)stringMatchID{
    
    
    _currentMatchID = [stringMatchID intValue];

    _participants = [NSMutableArray array];
    _indexOfAIParticepents = [NSMutableArray array];
    _linesToAddToGrid = [NSMutableArray array];
    _squaresForPlayer1 = [NSMutableArray array];
    _squaresForPlayer2 = [NSMutableArray array];
    _squaresForPlayer3 = [NSMutableArray array];
    _squaresForPlayer4 = [NSMutableArray array];
    
    _lastLinesToAddToGrid = [NSMutableArray array];
    _lastSquaresForPlayer1 = [NSMutableArray array];
    _lastSquaresForPlayer2 = [NSMutableArray array];
    _lastSquaresForPlayer3 = [NSMutableArray array];
    _lastSquaresForPlayer4 = [NSMutableArray array];
    
    [_participants removeAllObjects];
    [_indexOfAIParticepents removeAllObjects];
    [_linesToAddToGrid removeAllObjects];
    [_squaresForPlayer1 removeAllObjects];
    [_squaresForPlayer2 removeAllObjects];
    [_squaresForPlayer3 removeAllObjects];
    [_squaresForPlayer4 removeAllObjects];
    
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"%dLocalMatch",_currentMatchID]];
    
    for (NSString * key in dict) {
        if ([key isEqualToString:@"currentPlayerIndex"]) {
            _currentParticipantIndex = [[dict objectForKey:key]integerValue];
        }
        else if ([key isEqualToString:@"participants"]) {
            for (id object in [dict objectForKey:key]) {
                [_participants addObject:object];
            }
        }
        else if ([key isEqualToString:@"indexOfAIParticpents"]) {
            for (id object in [dict objectForKey:key]) {
                [_indexOfAIParticepents addObject:object];
            }
        }
        else if ([key isEqualToString:@"linesToAddToGrid"]) {
            for (id object in [dict objectForKey:key]) {
                [_linesToAddToGrid addObject:object];
            }
        }
        else if ([key isEqualToString:@"squaresForPlayer1"]) {
            for (id object in [dict objectForKey:key]) {
                [_squaresForPlayer1 addObject:object];
            }
        }
        else if ([key isEqualToString:@"squaresForPlayer2"]) {
            for (id object in [dict objectForKey:key]) {
                [_squaresForPlayer2 addObject:object];
            }
        }
        else if ([key isEqualToString:@"squaresForPlayer3"]) {
            for (id object in [dict objectForKey:key]) {
                [_squaresForPlayer3 addObject:object];
            }
        }
        else if ([key isEqualToString:@"squaresForPlayer4"]) {
            for (id object in [dict objectForKey:key]) {
                [_squaresForPlayer4 addObject:object];
            }
        }
    }
    _currentMatchName = [dict objectForKey:@"MatchName"];
    
    [_lastLinesToAddToGrid removeAllObjects];
    [_lastSquaresForPlayer1 removeAllObjects];
    [_lastSquaresForPlayer2 removeAllObjects];
    [_lastSquaresForPlayer3 removeAllObjects];
    [_lastSquaresForPlayer4 removeAllObjects];
    for (id object in _linesToAddToGrid) {
        [_lastLinesToAddToGrid addObject:object];
    }
    for (id object in _squaresForPlayer1) {
        [_lastSquaresForPlayer1 addObject:object];
    }
    for (id object in _squaresForPlayer2) {
        [_lastSquaresForPlayer2 addObject:object];
    }
    for (id object in _squaresForPlayer3) {
        [_lastSquaresForPlayer3 addObject:object];
    }
    for (id object in _squaresForPlayer4) {
        [_lastSquaresForPlayer4 addObject:object];
    }
}

- (int) playerCountForMatchWithID:(NSString *)stringMatchID {
    
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"%@LocalMatch",stringMatchID]];
    NSMutableArray *particpentsToCount = [dict objectForKey:@"participants"];
    return particpentsToCount.count;
}


-(NSString *) participantsForMatchWithID:(NSString *)stringMatchID atIndex:(int)index {
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"%@LocalMatch",stringMatchID]];
    NSString *part = [[dict objectForKey:@"participants"]objectAtIndex:index];
    NSMutableArray *AI = [dict objectForKey:@"indexOfAIParticpents"];
    
    for (NSString * AIplayers in AI) {
        if ([AIplayers intValue] == index) {
            return [NSString stringWithFormat:@"%@ (AI)",part];
        }
    }
    return part;
    
}
- (NSString *) participantsForMatchWithID:(NSString *) stringMatchID{
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"%@LocalMatch",stringMatchID]];
    NSMutableArray *particpentsToReturn = [dict objectForKey:@"participants"];
    NSMutableArray *AI = [dict objectForKey:@"indexOfAIParticpents"];
    
    NSString * player1;
    NSString * player2;
    NSString * player3;
    NSString * player4;
    
    
    
    
    switch (particpentsToReturn.count) {
        case 2:
            player1 = particpentsToReturn[0];
            player2 = particpentsToReturn[1];
            for (NSString * AIIndexs in AI) {
                switch ([AIIndexs intValue]) {
                    case 0:
                        player1 = [NSString stringWithFormat:@"%@ (AI)",player1];
                        break;
                    case 1:
                        player2 = [NSString stringWithFormat:@"%@ (AI)",player2];
                        break;
                    case 2:
                        player3 = [NSString stringWithFormat:@"%@ (AI)",player3];
                        break;
                    case 3:
                        player4 = [NSString stringWithFormat:@"%@ (AI)",player4];
                        break;
                    default:
                        break;
                }
            }
            return [NSString stringWithFormat:@"%@ and %@",player1,player2];
            break;
        case 3:
            player1 = particpentsToReturn[0];
            player2 = particpentsToReturn[1];
            player3 = particpentsToReturn[2];
            for (NSString * AIIndexs in AI) {
                switch ([AIIndexs intValue]) {
                    case 0:
                        player1 = [NSString stringWithFormat:@"%@ (AI)",player1];
                        break;
                    case 1:
                        player2 = [NSString stringWithFormat:@"%@ (AI)",player2];
                        break;
                    case 2:
                        player3 = [NSString stringWithFormat:@"%@ (AI)",player3];
                        break;
                    case 3:
                        player4 = [NSString stringWithFormat:@"%@ (AI)",player4];
                        break;
                    default:
                        break;
                }
            }
            return [NSString stringWithFormat:@"%@, %@, and %@",player1,player2,player3];
            break;
        case 4:
            player1 = particpentsToReturn[0];
            player2 = particpentsToReturn[1];
            player3 = particpentsToReturn[2];
            player4 = particpentsToReturn[3];
            for (NSString * AIIndexs in AI) {
                switch ([AIIndexs intValue]) {
                    case 0:
                        player1 = [NSString stringWithFormat:@"%@ (AI)",player1];
                        break;
                    case 1:
                        player2 = [NSString stringWithFormat:@"%@ (AI)",player2];
                        break;
                    case 2:
                        player3 = [NSString stringWithFormat:@"%@ (AI)",player3];
                        break;
                    case 3:
                        player4 = [NSString stringWithFormat:@"%@ (AI)",player4];
                        break;
                    default:
                        break;
                }
            }
            return [NSString stringWithFormat:@"%@, %@, %@, and %@",player1,player2,player3,player4];
            break;
            
        default:
            break;
    }
    
    return @"ERROR";
}

-(NSString *) matchNameForID:(NSString *)stringMatchID{
     NSDictionary *dict = [[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"%@LocalMatch",stringMatchID]];
    return [NSString stringWithFormat:@"%@ - %d Players",[dict objectForKey:@"MatchName"],[self playerCountForMatchWithID:stringMatchID]];
}

-(void) setInitalMatch {
    NSMutableArray * firstParticpents = [NSMutableArray arrayWithObjects:@"Andrew",@"Carol",@"Lisa",@"Tom", nil];
    NSMutableArray * ai = [NSMutableArray arrayWithObjects:@"0",@"1",@"2",@"3", nil];
    
    NSArray * objectsForDictionary = [NSArray arrayWithObjects:@"Demo Match",@"0", firstParticpents, ai, nil];
    
    NSArray * keysForDictionary = [NSArray arrayWithObjects:@"MatchName",@"currentPlayerIndex", @"participants",@"indexOfAIParticpents", nil];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjects:objectsForDictionary forKeys:keysForDictionary];
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setValue:dict forKey:@"1LocalMatch"];
    
    NSMutableArray * allMatchIDS = [[NSMutableArray alloc]init];
    for (id objects in [defaults valueForKey:@"allMatchIDS"]) {
        [allMatchIDS addObject:objects];
    }
    [allMatchIDS addObject:@"1"];
    [defaults setValue:allMatchIDS forKey:@"allMatchIDS"];
    [defaults synchronize];
    
}

@end
