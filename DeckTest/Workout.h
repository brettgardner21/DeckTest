//
//  Workout.h
//  DeckTest
//
//  Created by Brett Gardner on 4/24/13.
//  Copyright (c) 2013 Brett Gardner. All rights reserved.
//

#import <Parse/Parse.h>
#import "Deck.h"

@interface Workout : PFObject<PFSubclassing>

@property (nonatomic, retain) Deck *deck;
@property (nonatomic, retain) PFUser *user;
@property (nonatomic, retain) NSDate *startDate;
@property (nonatomic, retain) NSDate *endDate;
@property NSTimeInterval duration;

+ (NSString *)parseClassName;

@end

