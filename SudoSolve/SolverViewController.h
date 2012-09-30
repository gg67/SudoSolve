//
//  SolverViewController.h
//  SudoSolve
//
//  Created by Graham Gaylor on 9/27/12.
//  Copyright (c) 2012 GGD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Solver.h"
#import "BoardCell.h"

@interface SolverViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSString *currentInputNumber;
@property (strong, nonatomic) Solver *solver;

- (IBAction)numberTapped:(UIButton *)sender;
- (IBAction)solveTapped:(UIButton *)sender;

@end
