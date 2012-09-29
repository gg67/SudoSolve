//
//  Solver.m
//  SudoSolve
//
//  Created by Graham Gaylor on 9/27/12.
//  Copyright (c) 2012 GGD. All rights reserved.
//

#import "Solver.h"

#define BOARD_SIZE 9

@implementation Solver
@synthesize board = _board;

/**
 * Default Initializer
 */
- (id)init {
    self = [super init];
	if (self != nil) {
        NSMutableArray *tmpArray = [NSMutableArray arrayWithCapacity:9];
        for (int i = 0; i < 9; i++) {
            NSMutableArray *tmpCol = [NSMutableArray arrayWithCapacity:9];
            for (int j=0; j<9; j++) {
                SSCell *cell = [[SSCell alloc] initWithNum:0 andRow:i andColumn:j];
                [tmpCol addObject:cell];
            }
            [tmpArray addObject:tmpCol];
        }
        _board = tmpArray;
	}
	return self;
}

/**
 * Reinitializes the object with a new puzzle from the specified file
 */
- (void)loadFromFile:(NSString *)filename {
    NSString* filePath = @"/Users/grahamgaylor/Developer/iOS/SudoSolve/SudoSolve/sudoku-test1.txt";

    // read everything from text
    NSString* fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    // remove \n's
    fileContents = [fileContents stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    // first, separate by new line
    NSArray* allLinedStrings = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    for (int i=0; i<BOARD_SIZE; i++) {
        // then break down even further
        NSString* strsInOneLine = [allLinedStrings objectAtIndex:i];
        
        // choose whatever input identity you have decided. in this case ;
        NSArray* singleStrs = [strsInOneLine componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@" "]];
        for (int j=0; j<BOARD_SIZE; j++) {
            NSString *stringNum = singleStrs[j];
            int num = [stringNum integerValue];
            SSCell *cell = [[SSCell alloc] initWithNum:num andRow:i andColumn:j];
            _board[i][j] = cell;
        }
    }
}

/**
 * Entry point for solver
 * Returns true if solution was found.
 * Returns false if no solution was found.
 */
- (bool)solve {
    SSCell *firstCell = _board[0][0];
    return [self solveNextCell:firstCell];
}

/**
 * Prints the puzzle contents to the screen in a nicely formatted manner
 */
- (void)print {
    for (int row = 0; row < 9; row++) {
        for (int col = 0; col < 9; col++) {
            SSCell *cell = _board[row][col];
            printf("%d ",cell.num);
        }
        printf("\n");
    }
    printf("\n");
}

/**
 * Recursive back tracking function
 */
- (bool)solveNextCell:(SSCell *)cell {
    SSCell *nextCell = [self nextCell:cell];
    
    // if square is filled, solve next square
    if (![self isCellEmpty:cell]) {
//        NSLog(@"Cell is not empty");
        if ([self checkCellForCompletion:cell]) {
            return true;
        }
        return [self solveNextCell:nextCell];
    }
    // if square is empty, loop 1-9 checking each for legality.
    else {
        for (int n=1; n<10; n++) {
            // if its legal, add it, and search next square
            if ([self placementIsLegalForCell:cell withNum:n]) {
                cell.num = n;
                // if at any point, row=col=8, then we're done.
                if ([self checkCellForCompletion:cell]) {
//                    NSLog(@"row = col= 8");
                    return YES;
                }
                if([self solveNextCell:nextCell]) {
//                    NSLog(@"Solving next square");
                    return YES;
                }
            }
        }
        // if no numbers work, reset the space and backtrack
        cell.num = 0;
        return NO;
        
    }
}

/**
 * Checks to see if square is already filled.
 */
- (bool)isCellEmpty:(SSCell *)cell {
    int num = cell.num;
    if (num == 0) {
        return YES;
    }
    return NO;
}

/**
 * Checks to see if puzzle is complete
 */
- (bool)checkCellForCompletion:(SSCell *)cell {
    return cell.row == 8 && cell.col == 8;
}

/**
 * Setters and Getters for our matirx
 */
- (void)setCellForRow:(int)row andColumn:(int)col {
    SSCell *cell = _board[row][col];
    cell.row = row;
    cell.col = col;
}

- (SSCell *)cellForRow:(int)row andColumn:(int)col {
    SSCell *cell = _board[row][col];
    return cell;
}


/**
 * Helper methods to check if number insertion is legal
 */
- (bool)checkRowForCell:(SSCell *)cell withNum:(int)num {
    SSCell *otherCell = nil;
    for (int i=0; i<BOARD_SIZE; i++) {
        otherCell = [self cellForRow:cell.row andColumn:i];
        if (otherCell.num == num)
            return NO;
    }
    return YES;
}
- (bool)checkColumnForCell:(SSCell *)cell withNum:(int)num {
    SSCell *otherCell = nil;
    for (int i=0; i<BOARD_SIZE; i++) {
        otherCell = [self cellForRow:i andColumn:cell.col];
        if (otherCell.num == num)
            return NO;
    }
    return YES;
}
- (bool)checkSquareForCell:(SSCell *)cell withNum:(int)num {
    SSCell *compareCell = nil;
    if (cell.row < 3) {
        if (cell.col < 3) {
            // Quad 1
            for (int i=0; i<3; i++) {
                for (int j=0; j<3; j++) {
                    compareCell = [self cellForRow:i andColumn:j];
                    if(compareCell.num == num)
                        return NO;
                }
            }
        }
        else if (cell.col < 6) {
            // Quad 2
            for (int i=0; i<3; i++) {
                for (int j=3; j<6; j++) {
                    compareCell = _board[i][j];
                    if(compareCell.num == num)
                        return NO;
                }
            }
        }
        else {
            // Quad 3
            for (int i=0; i<3; i++) {
                for (int j=6; j<9; j++) {
                    compareCell = _board[i][j];
                    if(compareCell.num == num)
                        return NO;
                }
            }
        }
    } else if (cell.row < 6) {
        if (cell.col < 3) {
            // Quad 4
            for (int i=3; i<6; i++) {
                for (int j=0; j<3; j++) {
                    compareCell = _board[i][j];
                    if(compareCell.num == num)
                        return NO;
                }
            }
        }
        else if (cell.col < 6) {
            // Quad 5
            for (int i=3; i<6; i++) {
                for (int j=3; j<6; j++) {
                    compareCell = _board[i][j];
                    if(compareCell.num == num)
                        return NO;
                }
            }
        }
        else {
            // Quad 6
            for (int i=3; i<6; i++) {
                for (int j=6; j<9; j++) {
                    compareCell = _board[i][j];
                    if(compareCell.num == num)
                        return NO;
                }
            }
        }
    } else {
        if (cell.col < 3) {
            // Quad 7
            for (int i=6; i<9; i++) {
                for (int j=0; j<3; j++) {
                    compareCell = _board[i][j];
                    if(compareCell.num == num)
                        return NO;
                }
            }
        }
        else if (cell.col < 6) {
            // Quad 8
            for (int i=6; i<9; i++) {
                for (int j=3; j<6; j++) {
                    compareCell = _board[i][j];
                    if(compareCell.num == num)
                        return NO;
                }
            }
        } else {
            // Quad 9
            for (int i=6; i<9; i++) {
                for (int j=6; j<9; j++) {
                    compareCell = _board[i][j];
                    if(compareCell.num == num)
                        return NO;
                }
            }
        }
    }
    return YES;
}
- (bool)placementIsLegalForCell:(SSCell *)cell withNum:(int)num {
    return [self checkRowForCell:cell withNum:num] && [self checkColumnForCell:cell withNum:num] && [self checkSquareForCell:cell withNum:num];
}

/*
 * Helper methods to get next row/column
 * Take into account there are only 9 rows and columns
 */
- (SSCell *) nextCell:(SSCell *)cell {
    if (cell.row == 8 && cell.col == 8) {
        return nil;
    }
    int nextRow, nextCol;
    if (cell.col == 8) {
        nextRow = cell.row+1;
        nextCol = 0;
    }
    else {
        nextRow = cell.row;
        nextCol = cell.col+1;
    }
    
    SSCell *nextCell = _board[nextRow][nextCol];
    return nextCell;
        
}


@end
