//
//  Deck.m
//  DeckTest
//
//  Created by Brett Gardner on 4/24/13.
//  Copyright (c) 2013 Brett Gardner. All rights reserved.
//

#import <Parse/PFObject+Subclass.h>
#import "Deck.h"

@implementation Deck

@dynamic name;
@dynamic description;

+ (NSString *)parseClassName {
    return @"Deck";
}
- (NSMutableArray *) getCards {
    //get all cards for the test deck
    PFQuery *query = [PFQuery queryWithClassName:@"Card"];
    
    // Follow relationship
    [query whereKey:@"deck" equalTo:self];
    [query includeKey:@"exercise"];
    NSMutableArray *cards = [[query findObjects] mutableCopy];
    return cards;
    
}

@end
