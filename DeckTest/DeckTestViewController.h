//
//  DeckTestViewController.h
//  DeckTest
//
//  Created by Brett Gardner on 3/10/13.
//  Copyright (c) 2013 Brett Gardner. All rights reserved.
//
#import <Parse/Parse.h>
#import <UIKit/UIKit.h>

@interface DeckTestViewController : UIViewController <UIGestureRecognizerDelegate> {
    
    UIView *subView;

}

@property (nonatomic,retain) UIView *subView;
@property (strong, nonatomic) IBOutlet UILabel *timerLabel;
@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) IBOutlet UIButton *onResetPressed;
@property (strong, nonatomic) IBOutlet UILabel *deckLabel;

- (IBAction)onStartPressed:(id)sender;
- (IBAction)onStopPressed:(id)sender;
- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer;


@end


