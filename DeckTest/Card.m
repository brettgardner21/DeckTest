//
//  Card.m
//  DeckTest
//
//  Created by Brett Gardner on 4/30/13.
//  Copyright (c) 2013 Brett Gardner. All rights reserved.
//

#import "Card.h"
#import <Parse/PFObject+Subclass.h>


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

+ (NSString *)parseClassName {
    return @"Card";
}

//nick begin
@synthesize value, cardSuit;
- (id) initWithValue:(NSInteger) aValue suit:(Suit) aSuit {
	if(self = [super init]) {
		self.value = aValue;
		self.cardSuit = aSuit;
	}
	return self;
}
- (NSString *) valueAsString {
	switch (self.value) {
		case Ace:
			return @"Ace";
			break;
		case Jack:
			return @"Jack";
			break;
		case Queen:
			return @"Queen";
			break;
		case King:
			return @"King";
			break;
		default:
			return [NSString stringWithFormat:@"%d",self.value];
			break;
	}
}
- (NSString *) suitAsString {
	switch (self.cardSuit) {
		case Hearts:
			return @"Hearts";
			break;
		case Diamonds:
			return @"Diamonds";
			break;
		case Spades:
			return @"Spades";
			break;
		case Clubs:
			return @"Clubs";
			break;
		default:
			return nil;
			break;
	}
}
- (NSString *) description {
	return [NSString stringWithFormat:@"%@ of %@",
			[self valueAsString],
			[self suitAsString]];
}
//end nick

@end

