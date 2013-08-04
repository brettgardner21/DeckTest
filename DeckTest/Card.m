//
//  Card.m
//  DeckTest
//
//  Created by Brett Gardner on 4/30/13.
//  Copyright (c) 2013 Brett Gardner. All rights reserved.
//

#import "Card.h"
#import <Parse/PFObject+Subclass.h>
#import "DeckTestAppDelegate.h"

//nick begin
@interface Card(Private)

- (NSString *) valueAsString;
- (NSString *) suitAsString;

@end
//end nick


@implementation Card


@dynamic suit;
@dynamic faceValue;
@dynamic reps;
@dynamic deck;
@dynamic exercise;
@dynamic image;
@dynamic exerciseString;

+ (NSString *)parseClassName {
    return @"Card";
}

//nick begin
@synthesize value, cardSuit;
- (id) initWithValue:(NSInteger) aValue suit:(Suit) aSuit {
	if(self = [super init]) {
		self.value = aValue;
		self.cardSuit = aSuit; //this is a typedef, not a string. Need to change.
        
        // prototype setup:
        //query dictionary using aValue and aSuit to populate card values
       /* NSString *keyString = [self suitTypeToString:aSuit];
        
        DeckTestAppDelegate *appDel = (DeckTestAppDelegate *)[[UIApplication sharedApplication] delegate];
        NSMutableDictionary * deckDictionary = [appDel.currentDeckDictionary objectForKey:keyString];
        
        NSEnumerator *enumerator = [deckDictionary keyEnumerator];
        id key;
        
        while ((key = [enumerator nextObject])) {
            /* code that uses the returned key */
           /* NSString *cardString = [deckDictionary objectForKey:key];
            self.exerciseString = cardString;
            NSLog(@"cardstring: %@",self.exerciseString);
            
        }
/*        NSArray *dictionaryKeys = [deckDictionary allKeys];
        for(int i = 0; i < [dictionaryKeys count] ; i++) {
            NSString *indexString = [dictionaryKeys objectAtIndex:i];
            NSString *cardString = [deckDictionary objectForKey:indexString];
            self.exerciseString = cardString;
            NSLog(@"cardstring: %@",self.exerciseString);
        } */
	}
	return self;
}
- (NSString*)suitTypeToString:(Suit)suitType { //this one needs the actual suit spelled out so the dictionary can use it as a key.
    NSString *result = nil;
    
    switch(suitType) {
        case Hearts:
            result = @"Hearts";
            break;
        case Clubs:
            result = @"Clubs";
            break;
        case Diamonds:
            result = @"Diamonds";
            break;
        case Spades:
            result = @"Spades";
            break;
        default:
            [NSException raise:NSGenericException format:@"Unexpected FormatType."];
    }
    
    return result;
}
- (NSString *) valueAsString {
	switch (self.value) {
		case Ace:
			return @"A(14)";
			break;
		case Jack:
			return @"J(11)";
			break;
		case Queen:
			return @"Q(12)";
			break;
		case King:
			return @"K(13)";
			break;
		default:
			return [NSString stringWithFormat:@"%d",self.value];
			break;
	}
}
- (NSString *) suitAsString {
	switch (self.cardSuit) {
		case Hearts:
			return @"♥";
			break;
		case Diamonds:
			return @"♦";
			break;
		case Spades:
			return @"♠";
			break;
		case Clubs:
			return @"♣";
			break;
		default:
			return nil;
			break;
	}
}
- (NSString *) description { //generates text to populate label on card.
	return [NSString stringWithFormat:@"%@%@ %@",
			[self valueAsString],
			[self suitAsString],
            self.exerciseString];
}
//end nick

@end

