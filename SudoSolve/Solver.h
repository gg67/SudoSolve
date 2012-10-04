//
//  Solver.h
//  SudoSolve
//
//  Created by Graham Gaylor on 9/27/12.
//  Copyright (c) 2012 GGD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSCell.h"

#define BOARD_SIZE 9

SSCell *_board[BOARD_SIZE][BOARD_SIZE];

@interface Solver : NSObject

@property NSString *givenPuzzleString;


/**
 * Returns cell from row and col
 */
- (SSCell *)cellForRow:(int)row andColumn:(int)col;

/**
 * Sets cell number for row and col
 */
- (void)setCellNumber:(int)num ForRow:(int)row andColumn:(int)col;

/**
 * Reinitializes the object with a new puzzle from the specified file
 */
- (void)loadFromFile:(NSString *)filename;

/**
 * Entry point for sovler
 * Returns true if solution was found.
 * Returns false if no solution was found.
 */
- (bool)solve;

/**
 * Prints the puzzle contents to the screen in a nicely formatted manner
 */
- (void)print;

/**
 *
 */
- (NSString *)stringFromBoard;

/**
 * Recursive back tracking function
 */
- (bool)solveNextCell:(SSCell *)cell;

/**
 * Checks to see if square is already filled.
 */
- (bool)isCellEmpty:(SSCell *)cell;

/**
 * Checks to see if puzzle is complete
 */
- (bool)checkCellForCompletion:(SSCell *)cell;

/**
 * Helper methods to check if number insertion is legal
 */
- (bool)checkRowForCell:(SSCell *)cell withNum:(int)num;
- (bool)checkColumnForCell:(SSCell *)cell withNum:(int)num;
- (bool)checkSquareForCell:(SSCell *)cell withNum:(int)num;
- (bool)placementIsLegalForCell:(SSCell *)cell withNum:(int)num;

/*
 * Helper method to get next cell
 * Take into account there are only 9 rows and columns
 */
- (SSCell *) nextCell:(SSCell *)cell;

@end
