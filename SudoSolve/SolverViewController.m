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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    Solver *solver = [[Solver alloc] init];
    [solver print];
    [solver loadFromFile:nil];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
