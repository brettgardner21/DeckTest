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

@interface WorkoutCard : PFObject<PFSubclassing>

@property (retain) Workout *workout;
@property (retain) Card *card;
@property Boolean isComplete;

+ (NSString *)parseClassName;

@end
