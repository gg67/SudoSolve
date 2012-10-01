//
//  SolverViewController.m
//  SudoSolve
//
//  Created by Graham Gaylor on 9/27/12.
//  Copyright (c) 2012 GGD. All rights reserved.
//

#import "SolverViewController.h"

@interface SolverViewController ()

@end

@implementation SolverViewController
@synthesize collectionView = _collectionView;
@synthesize solver = _solver;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - UICollectionViewDataSource Protocol Methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 9;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BoardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BoardCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    BoardCell *cell = (BoardCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.numberLabel.text = self.currentInputNumber;
    int row = indexPath.section;
    int col = indexPath.row;
    SSCell *ssCell = _solver.board[row][col];
    ssCell.num = [self.currentInputNumber intValue];    
    
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}


#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    self.currentInputNumber = 0;
    self.solver = [[Solver alloc] init];
}


- (void)viewDidUnload {
    [self setCollectionView:nil];
    [super viewDidUnload];
}

#pragma mark - Helper Methods
-(void)fillInCollectionView {
    for (int i=0; i<9; i++) {
        for (int j=0; j<9; j++) {
            NSUInteger indexArr[] = {i,j};
            NSIndexPath *path = [NSIndexPath indexPathWithIndexes:indexArr length:2];
            BoardCell *boardCell = (BoardCell *)[self.collectionView cellForItemAtIndexPath:path];
            SSCell *ssCell = _solver.board[i][j];
            boardCell.numberLabel.text = [NSString stringWithFormat:@"%d", ssCell.num];
        }
    }
}

#pragma mark - IBAction Methods
- (IBAction)numberTapped:(UIButton *)sender {
    self.currentInputNumber = sender.titleLabel.text;
}

- (IBAction)solveTapped:(UIButton *)sender {
    if ([self.solver solve]) {
        [self fillInCollectionView];
        [self.solver print];
    } else {
        NSLog(@"Puzzle not solvable");
    }
}

- (IBAction)clearTapped:(UIButton *)sender {
    self.solver = [[Solver alloc] init];
    [self fillInCollectionView];
}
@end
