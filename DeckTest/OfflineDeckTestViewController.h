//
//  OfflineDeckTestViewController.h
//  DeckTest
//
//  Created by Nicholas Terry on 6/10/13.
//  Copyright (c) 2013 Brett Gardner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OfflineDeckTestViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *goButton;
@property (weak, nonatomic) IBOutlet UIImageView *cardImageView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardSuitLabel;

- (IBAction)goButtonPressed:(id)sender;
- (IBAction)swipeGesture:(id)sender;
@end


