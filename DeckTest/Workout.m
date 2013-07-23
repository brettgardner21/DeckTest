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
- (NSMutableArray *) getWorkoutCards {
    //get all workoutcards attached to the deck
    PFQuery *query = [PFQuery queryWithClassName:@"WorkoutCard"];
    
    // Follow relationship
    [query whereKey:@"workout" equalTo:self];
    [query includeKey:@"card"];
    [query includeKey:@"exercise"];
    NSMutableArray *cards = [[query findObjects] mutableCopy];
    return cards;
}

@end
