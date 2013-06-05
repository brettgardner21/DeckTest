//
//  Exercise.m
//  DeckTest
//
//  Created by Brett Gardner on 4/30/13.
//  Copyright (c) 2013 Brett Gardner. All rights reserved.
//

#import "Exercise.h"
#import <Parse/PFObject+Subclass.h>

@implementation Exercise

@dynamic name;
@dynamic description;
@dynamic videoURL;
@dynamic image;

+ (NSString *)parseClassName {
    return @"Exercise";
}

@end
