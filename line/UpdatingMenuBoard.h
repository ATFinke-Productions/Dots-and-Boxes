//
//  UpdatingMenuBoard.h
//  dot
//
//  Created by Andrew on 4/6/13.
//  Copyright (c) 2013 Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdatingMenuBoard : UIView {
    
    int playerNumberTurn;
    BOOL justTookSquare;
    BOOL isShowingResults;

    NSUserDefaults * defaults;
    CATransition *transition;
    
    NSMutableArray *linesToAddToGrid;
    NSMutableArray *squaresForPlayer1;
    NSMutableArray *squaresForPlayer2;
    NSMutableArray *squaresForPlayer3;
    NSMutableArray *squaresForPlayer4;
    NSMutableArray *allSquares;
    
    NSMutableArray *square01;
    NSMutableArray *square02;
    NSMutableArray *square03;
    NSMutableArray *square04;
    NSMutableArray *square05;
    NSMutableArray *square06;
    NSMutableArray *square07;
    NSMutableArray *square08;
    NSMutableArray *square09;
    NSMutableArray *square10;
    NSMutableArray *square11;
    NSMutableArray *square12;
    NSMutableArray *square13;
    NSMutableArray *square14;
    NSMutableArray *square15;
    NSMutableArray *square16;
}

@end
