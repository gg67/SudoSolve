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
 * Entry point for sovler
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
    
}

/**
 * Checks to see if square is already filled.
 */
- (bool)isCellEmpty:(SSCell *)cell {
    
}

/**
 * Checks to see if puzzle is complete
 */
- (bool)checkCellForCompletion:(SSCell *)cell {
    
}


/**
 * Helper methods to check if number insertion is legal
 */
- (bool)checkRow:(SSCell *)cell {
    
}
- (bool)checkColumn:(SSCell *)cell {
    
}
- (bool)checkSquare:(SSCell *)cell {
    
}
- (bool)placementIsLegal:(SSCell *)cell {
    
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
