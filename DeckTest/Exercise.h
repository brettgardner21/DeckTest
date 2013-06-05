//
//  Exercise.h
//  DeckTest
//
//  Created by Brett Gardner on 4/30/13.
//  Copyright (c) 2013 Brett Gardner. All rights reserved.
//

#import <Parse/Parse.h>

@interface Exercise : PFObject<PFSubclassing>

@property (retain) NSString *name;
@property (retain) NSString *description;
@property (retain) NSString *videoURL;
@property (retain) PFFile *image;

+ (NSString *)parseClassName;

@end
