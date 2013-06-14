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


//nick begin
typedef enum {
	Hearts,
	Diamonds,
	Spades,
	Clubs
} Suit;

#define Ace   1
#define Jack  11
#define Queen 12
#define King  13
//end nick

@interface Card : PFObject<PFSubclassing>

//nick begin
{
NSInteger value;
Suit cardSuit;
}

@property (nonatomic) NSInteger value;
@property (nonatomic) Suit cardSuit;
- (id) initWithValue:(NSInteger) aValue suit:(Suit) aSuit;
//end nick


@property (retain) NSString *suit;
@property (retain) NSString *faceValue;
@property int reps;
@property (retain) Deck *deck;
@property (retain) Exercise *exercise;
@property (retain) PFFile *image;

+ (NSString *)parseClassName;

@end

