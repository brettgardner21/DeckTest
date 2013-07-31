//
//  DeckTestAppDelegate.h
//  DeckTest
//
//  Created by Brett Gardner on 3/10/13.
//  Copyright (c) 2013 Brett Gardner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface DeckTestAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong) NSMutableDictionary *currentDeckDictionary;

@end
