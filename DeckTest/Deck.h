//
//  Deck.h
//  DeckTest
//
//  Created by Brett Gardner on 4/24/13.
//  Copyright (c) 2013 Brett Gardner. All rights reserved.
//

#import <Parse/Parse.h>
#import "Card.h"  //nick

@interface Deck : PFObject<PFSubclassing>

//nick begin
{
@private
	NSMutableArray *nicksCards;
}
- (void) shuffle;
- (Card *) draw;
- (NSInteger) cardsRemaining;
@property (strong) NSString *currentCard;
//end nick

@property (retain) NSString *name;
@property (retain) NSString *description;

+ (NSString *)parseClassName;
- (NSMutableArray *)getCards;


@end

