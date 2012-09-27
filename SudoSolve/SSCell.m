//
//  SSCell.m
//  SudoSolve
//
//  Created by Graham Gaylor on 9/27/12.
//  Copyright (c) 2012 GGD. All rights reserved.
//

#import "SSCell.h"

@implementation SSCell

@synthesize num = _num;
@synthesize row = _row;
@synthesize col = _col;

- (id)initWithNum:(int)num andRow:(int)row andColumn:(int)col {
    self = [super init];
	if (self != nil) {
        _num = num;
        _row = row;
        _col = col;
	}
	return self;
}


@end
