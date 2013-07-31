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

@synthesize currentCard; //nick

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


///////
//nick begin
- (id) init {
	if(self = [super init]) {
		nicksCards = [[NSMutableArray alloc] init];
		for(int i = 0; i <= 3; i++) { //suit - how to add Jokers?
			for(int value = 1; value <= 13; value++) { //rank
				Card *card = [[Card alloc] initWithValue:value suit:i];
				[nicksCards addObject:card];
			}
		}
        
	}
	return self;
}

/*
 * Random sort used from this blog post
 * http://zaldzbugz.wordpress.com/2010/07/16/randomly-sort-nsarray/
 */
int randomSort(id obj1, id obj2, void *context ) {
	// returns random number -1 0 1
	return (arc4random()%3 - 1);
}

- (void) shuffle {
	for(int x = 0; x < 500; x++) {
		[nicksCards sortUsingFunction:randomSort context:nil];
	}
}

- (Card *) draw {
 	if([self cardsRemaining] > 0) {
		Card *card = [nicksCards lastObject];
		[nicksCards removeLastObject];
//        self.currentCard = [NSString stringWithFormat:@"%ld%@",(long)card.value, card.cardSuit];
        self.currentCard = [card description];
        NSLog(@"%@ deck", currentCard);
		return card;
	} else
    //removing for now. /nick
/*	NSException* myException = [NSException
                                exceptionWithName:@"OutOfCardsException"
                                reason:@"Tried to draw a card from a deck with 0 cards."
                                userInfo:nil];
	@throw myException;
*/  return nil; //added to test. /nick
}

- (NSInteger) cardsRemaining {
	return [nicksCards count];
}

- (NSString *) description {
	NSString *desc = [NSString stringWithFormat:@"Deck with %d cards\n",[self cardsRemaining]];
	for(int x = 0; x < [self cardsRemaining]; x++) {
		desc = [desc stringByAppendingFormat:@"%@\n",[[nicksCards objectAtIndex:x] description]];
	}
	return desc;
}
//end nick

@end




