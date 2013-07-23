//
//  WorkoutCard.m
//  DeckTest
//
//  Created by Brett Gardner on 5/6/13.
//  Copyright (c) 2013 Brett Gardner. All rights reserved.
//

#import "WorkoutCard.h"
#import <Parse/PFObject+Subclass.h>

@implementation WorkoutCard

@dynamic workout;
@dynamic card;
@dynamic exercise;
@dynamic isComplete;

+ (NSString *)parseClassName {
    return @"WorkoutCard";
}

@end
