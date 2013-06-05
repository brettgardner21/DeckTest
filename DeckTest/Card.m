//
//  Card.m
//  DeckTest
//
//  Created by Brett Gardner on 4/30/13.
//  Copyright (c) 2013 Brett Gardner. All rights reserved.
//

#import "Card.h"
#import <Parse/PFObject+Subclass.h>

@implementation Card

@dynamic suit;
@dynamic faceValue;
@dynamic reps;
@dynamic deck;
@dynamic exercise;
@dynamic image;

+ (NSString *)parseClassName {
    return @"Card";
}

@end
