//
//  Card.h
//  DeckTest
//
//  Created by Brett Gardner on 4/30/13.
//  Copyright (c) 2013 Brett Gardner. All rights reserved.
//

#import <Parse/Parse.h>
@class Deck;
@class Exercise;

@interface Card : PFObject<PFSubclassing>

@property (retain) NSString *suit;
@property (retain) NSString *faceValue;
@property int reps;
@property (retain) Deck *deck;
@property (retain) Exercise *exercise;
@property (retain) PFFile *image;

+ (NSString *)parseClassName;

@end
