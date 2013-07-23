//
//  WorkoutRunner.m
//  DeckTest
//
//  Created by Brett Gardner on 7/1/13.
//  Copyright (c) 2013 Brett Gardner. All rights reserved.
//

#import "WorkoutRunner.h"
#import "Workout.h"

@implementation WorkoutRunner


- (id) initWithWorkout: (Workout *) workout {
    
    // Call superclass's initializer
    self = [super init];
    if( !self ) return nil;
    
    self.workout = workout;
    
    return self;
}

- (id) initWithDeck: (Deck *) deck {
    
    // Call superclass's initializer
    self = [super init];
    if( !self ) return nil;
    
    self.workout = [[Workout alloc] init];
    self.workout.deck = deck;
    
    return self;
}
@end
