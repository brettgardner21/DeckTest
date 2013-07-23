//
//  WorkoutCard.h
//  DeckTest
//
//  Created by Brett Gardner on 5/6/13.
//  Copyright (c) 2013 Brett Gardner. All rights reserved.
//

#import <Parse/Parse.h>
@class Card;
@class Workout;
@class Exercise;

@interface WorkoutCard : PFObject<PFSubclassing>

@property (retain) Workout *workout;
@property (retain) Card *card;
@property (retain) Exercise *exercise;
@property Boolean isComplete;

+ (NSString *)parseClassName;

@end
