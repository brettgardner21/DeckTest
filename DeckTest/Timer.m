//
//  Timer.m
//  DeckTest
//
//  Created by Brett Gardner on 7/1/13.
//  Copyright (c) 2013 Brett Gardner. All rights reserved.
//

#import "Timer.h"

@implementation Timer

- (id) initWithElapsedTime: (NSTimeInterval)time {
    
    // Call superclass's initializer
    self = [super init];
    if( !self ) return nil;
    
    self.elapsedTime = time;
    
    return self;
}

-(void) startTimer {
    self.startDate = [NSDate date];
    
    // Create the stop watch timer that fires every 100 ms
    self.stopWatchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                           target:self
                                                         selector:@selector(updateTimer)
                                                         userInfo:nil
                                                          repeats:YES];
}



@end
