//
//  NSMutableArray_Shuffle.m
//  DeckTest
//
//  Created by Brett Gardner on 5/3/13.
//  Copyright (c) 2013 Brett Gardner. All rights reserved.
//

#import "NSMutableArray_Shuffle.h"

@implementation NSMutableArray (Shuffle)

- (void)shuffle
{
    NSUInteger count = [self count];
    for (NSUInteger i = 0; i < count; ++i) {
        // Select a random element between i and end of array to swap with.
        NSInteger nElements = count - i;
        NSInteger n = (arc4random() % nElements) + i;
        [self exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}

@end
