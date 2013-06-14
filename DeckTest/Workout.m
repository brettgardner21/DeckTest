//
//  Workout.m
//  DeckTest
//
//  Created by Brett Gardner on 4/24/13.
//  Copyright (c) 2013 Brett Gardner. All rights reserved.
//

#import "Workout.h"
#import <Parse/PFObject+Subclass.h>
#import "Deck.h"

@implementation Workout

@dynamic deck;
@dynamic user;
@dynamic startDate;
@dynamic endDate;
@dynamic duration;


+ (NSString *)parseClassName {
    return @"Workout";
}

@end
