//
//  Solver.h
//  SudoSolve
//
//  Created by Graham Gaylor on 9/27/12.
//  Copyright (c) 2012 GGD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSCell.h"


@interface Solver : NSObject

@property NSArray *board;

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
- (bool)checkRow:(SSCell *)cell;
- (bool)checkColumn:(SSCell *)cell;
- (bool)checkSquare:(SSCell *)cell;
- (bool)placementIsLegal:(SSCell *)cell;

/*
 * Helper methods to get next row/column
 * Take into account there are only 9 rows and columns
 */
- (int) nextRow:(SSCell *)cell;
- (int) nextCol:(SSCell *)cell;

@end
