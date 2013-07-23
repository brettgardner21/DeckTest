//
//  Timer.h
//  DeckTest
//
//  Created by Brett Gardner on 7/1/13.
//  Copyright (c) 2013 Brett Gardner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Timer : NSObject

@property (strong, nonatomic) NSTimer *stopWatchTimer; // Store the timer that fires after a certain time
@property (strong, nonatomic) NSDate *startDate; // Stores the date of the click on the start button
@property NSTimeInterval elapsedTime; //Elapsed Time

-(void)startTimer;

@end
