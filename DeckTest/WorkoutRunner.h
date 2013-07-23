//
//  WorkoutRunner.h
//  DeckTest
//
//  Created by Brett Gardner on 7/1/13.
//  Copyright (c) 2013 Brett Gardner. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Deck;
@class Workout;

@interface WorkoutRunner : NSObject


- (void) startWorkout;
- (NSInteger) cardsRemaining;
- (id) initWithWorkout: (Workout *) workout;
- (id) initWithDeck: (Deck *) workout;


@property (nonatomic, copy) Workout *workout;



@end
