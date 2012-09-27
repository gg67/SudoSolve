//
//  SSCell.h
//  SudoSolve
//
//  Created by Graham Gaylor on 9/27/12.
//  Copyright (c) 2012 GGD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSCell : NSObject

@property int num;
@property int row;
@property int col;

- (id)initWithNum:(int)num andRow:(int)row andColumn:(int)col;

@end
