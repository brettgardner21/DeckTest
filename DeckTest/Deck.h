//
//  Deck.h
//  DeckTest
//
//  Created by Brett Gardner on 4/24/13.
//  Copyright (c) 2013 Brett Gardner. All rights reserved.
//

#import <Parse/Parse.h>

@interface Deck : PFObject<PFSubclassing>

@property (retain) NSString *name;
@property (retain) NSString *description;

+ (NSString *)parseClassName;
- (NSMutableArray *)getCards;
@end
