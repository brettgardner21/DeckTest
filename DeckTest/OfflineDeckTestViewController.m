//
//  OfflineDeckTestViewController.m
//  DeckTest
//
//  Created by Nicholas Terry on 6/10/13.
//  Copyright (c) 2013 Brett Gardner. All rights reserved.
//

#import "OfflineDeckTestViewController.h"
#import "Workout.h"
#import "Deck.h"

@interface OfflineDeckTestViewController ()

@property (strong, nonatomic) NSTimer *stopWatchTimer; // Store the timer that fires after a certain time
@property (strong, nonatomic) NSDate *startDate; // Stores the date of the click on the start button
@property NSTimeInterval elapsedTime; //Elapsed Time
@property (strong) Workout *currentWorkout;

@property Deck *d;
@property float currentProgress;
@property int cardCount;
@end

@implementation OfflineDeckTestViewController

@synthesize d;
@synthesize currentProgress, cardCount;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //setup
    //generate workout based on Deck selection. We can use segues for this.
    //How should the workout persist? Save the workout object to disk here.
        //How many should be saveable?
    self.d = [[Deck alloc] init];
	NSLog(@"%@",d);
    
	[d shuffle];
	NSLog(@"%@",d);
    /*
	NSLog(@"Drew Card: %@",[d draw]);
	NSLog(@"Drew Card: %@",[d draw]);
	NSLog(@"Drew Card: %@",[d draw]);
	NSLog(@"Drew Card: %@",[d draw]);
    
	NSLog(@"%@",d);
    */
    
    self.currentProgress = 0;
    self.progressBar.progress = 0;
    self.cardCount = 0;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UI Interfacing
- (void)updateTimer
{
    // Create date from the elapsed time
    NSDate *currentDate = [NSDate date]; //get current time
    NSTimeInterval timer = [currentDate timeIntervalSinceDate:self.startDate] + self.elapsedTime; //get time elapsed
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timer];//set timer date as seconds since beginning of time
    
    // Create a date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss.S"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    
    // Format the elapsed time and set it to the label
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
    self.timerLabel.text = timeString;
}

-(void)updateTopCard {
    self.cardSuitLabel.text = d.currentCard;
    NSLog(@"%@", d.currentCard);
    
    //advance progress bar and label. reorg this later.
    currentProgress = currentProgress + 1/52.0;
    self.progressBar.progress = currentProgress;
    cardCount = cardCount + 1;
    self.progressLabel.text = [NSString stringWithFormat:@"%d/52",cardCount];
    NSLog(@"%d",cardCount);
}

#pragma mark Actions
- (IBAction)goButtonPressed:(id)sender {
    
    //set state: flips between button states
    UIButton *button = (UIButton*)sender;
    button.selected = !button.selected;
    
    if (button.selected) {
        NSLog(@"Go.");
        [self.d draw];
        [self updateTopCard];
        
        //start/stop timer
        self.startDate = [NSDate date];
        
        // Create the stop watch timer that fires every 100 ms
        self.stopWatchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                               target:self
                                                             selector:@selector(updateTimer)
                                                             userInfo:nil
                                                              repeats:YES];
        
        
    } else if (!button.selected) {
        
        self.elapsedTime += [[NSDate date] timeIntervalSinceDate:self.startDate];
        [self.stopWatchTimer invalidate];
        self.stopWatchTimer = nil;
        //[self updateTimer];
        
        
    }
}

- (IBAction)swipeGesture:(id)sender {
    NSLog(@"Swipe.");
    if (d.cardsRemaining > 0) {
        [self.d draw];
        [self updateTopCard];
    } else if (d.cardsRemaining <= 0) {
        self.cardSuitLabel.text = @"Done.";
        [self.stopWatchTimer invalidate];
    }
}



@end
