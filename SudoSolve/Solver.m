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
    
    [self print];
}

/**
 * Entry point for solver
 * Returns true if solution was found.
 * Returns false if no solution was found.
 */
- (bool)solve {
    
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
    int _nextRow = nextRow(cell.row,cell.col);
    int _nextCol = nextCol(cell.row,cell.col);
    
    // if square is filled, solve next square
    if (!isEmpty(cell.row,cell.col)) {
        if (isComplete(cell.row,cell.col)) {
            return true;
        }
        return solveNextCell_nextRow, _nextCol);
    }
    // if square is empty, loop 1-9 checking each for legality.
    else {
        for (int n=1; n<10; n++) {
            // if its legal, add it, and search next square
            if (placementIsLegal(n,cell.row,cell.col)) {
                _board[row][col] = n;
                
                // if at any point, row=col=8, then we're done.
                if (isComplete(row,col)) {
                    // cout << "row = col = 8" << endl;
                    return YES;
                }
                if(addNum(_nextRow, _nextCol)) {
                    // cout << "Solving next square" << endl;
                    return YES;
                }
            }
        }
        // if no numbers work, reset the space and backtrack
        _board[row][col] = 0;
        return NO;
        
    }
}

/**
 * Checks to see if square is already filled.
 */
- (bool)isCellEmpty:(SSCell *)cell {
    if (_board[cell.row][cell.col] == 0) {
        return YES;
    }
    return YES;
}

/**
 * Checks to see if puzzle is complete
 */
- (bool)checkCellForCompletion:(SSCell *)cell {
    return cell.row == 8 && cell.col == 8;
}


/**
 * Helper methods to check if number insertion is legal
 */
- (bool)checkRow:(SSCell *)cell {
    SSCell *otherCell = nil;
    for (int i=0; i<BOARD_SIZE; i++) {
        otherCell = _board[cell.row][i];
        if (cell.num == otherCell.num)
            return NO;
    }
    return YES;
}
- (bool)checkColumn:(SSCell *)cell {
    SSCell *otherCell = nil;
    for (int i=0; i<BOARD_SIZE; i++) {
        otherCell = _board[i][cell.col];
        if (cell.num == otherCell.num)
            return NO;
    }
    return YES;
}
- (bool)checkSquare:(SSCell *)cell {
    SSCell *compareCell = nil;
    if (cell.row < 3) {
        if (cell.col < 3) {
            // Quad 1
            for (int i=0; i<3; i++) {
                for (int j=0; j<3; j++) {
                    compareCell = _board[i][j];
                    if(compareCell.num == cell.num)
                        return NO;
                }
            }
        }
        else if (cell.col < 6) {
            // Quad 2
            for (int i=0; i<3; i++) {
                for (int j=3; j<6; j++) {
                    compareCell = _board[i][j];
                    if(compareCell.num == cell.num)
                        return NO;
                }
            }
        }
        else {
            // Quad 3
            for (int i=0; i<3; i++) {
                for (int j=6; j<9; j++) {
                    compareCell = _board[i][j];
                    if(compareCell.num == cell.num)
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
                    if(compareCell.num == cell.num)
                        return NO;
                }
            }
        }
        else if (cell.col < 6) {
            // Quad 5
            for (int i=3; i<6; i++) {
                for (int j=3; j<6; j++) {
                    compareCell = _board[i][j];
                    if(compareCell.num == cell.num)
                        return NO;
                }
            }
        }
        else {
            // Quad 6
            for (int i=3; i<6; i++) {
                for (int j=6; j<9; j++) {
                    compareCell = _board[i][j];
                    if(compareCell.num == cell.num)
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
                    if(compareCell.num == cell.num)
                        return NO;
                }
            }
        }
        else if (cell.col < 6) {
            // Quad 8
            for (int i=6; i<9; i++) {
                for (int j=3; j<6; j++) {
                    compareCell = _board[i][j];
                    if(compareCell.num == cell.num)
                        return NO;
                }
            }
        } else {
            // Quad 9
            for (int i=6; i<9; i++) {
                for (int j=6; j<9; j++) {
                    compareCell = _board[i][j];
                    if(compareCell.num == cell.num)
                        return NO;
                }
            }
        }
    }
    return YES;
}
- (bool)placementIsLegal:(SSCell *)cell {
    return checkRow(cell.num, cell.row) && checkColumn(cell.num, cell.col) && checkSquare(cell.num,cell.row,cell.col);
}

/*
 * Helper methods to get next row/column
 * Take into account there are only 9 rows and columns
 */
- (int) nextRow:(SSCell *)cell {
    
}
- (int) nextCol:(SSCell *)cell {
    
}


@end
