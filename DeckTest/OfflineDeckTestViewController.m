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
#import "DeckTestAppDelegate.h"

@interface OfflineDeckTestViewController ()

@property (strong, nonatomic) NSTimer *stopWatchTimer; // Store the timer that fires after a certain time
@property (strong, nonatomic) NSDate *startDate; // Stores the date of the click on the start button
@property NSTimeInterval elapsedTime; //Elapsed Time
@property (strong) Workout *currentWorkout;

@property Deck *d;
@property float currentProgress;
@property int cardCount;
@property BOOL workoutHasBegun;
@end

@implementation OfflineDeckTestViewController

@synthesize d;
@synthesize currentProgress, cardCount;

#pragma mark - Init
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //not called when using storyboard.
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated {
    [UIApplication sharedApplication].idleTimerDisabled = NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    self.workoutHasBegun = NO;
    
    [self deckDictionarySetup];
    
    //setup
    //generate workout based on Deck selection. We can use segues for this.
    //How should the workout persist? Save the workout object to disk here.
    //How many should be saveable?
    //We'll need to keep a persistent dictionary of each deck object generated or just the last if not completed?

    self.d = [[Deck alloc] init];
	[d shuffle];
    
    self.currentProgress = 0;
    self.progressBar.progress = 0;
    self.cardCount = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)deckDictionarySetup
{
    DeckTestAppDelegate *appDel = (DeckTestAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"LB1Deck.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //Creates the settings plist
    //Uncomment before release
    
    /*if (![fileManager fileExistsAtPath:plistPath]) {
     NSString *bundle = [[NSBundle mainBundle] pathForResource:@"settings" ofType:@"plist"];
     [fileManager copyItemAtPath:bundle toPath:plistPath error:&error];
     
     } */
    
    //overwrites plist with bundle plist.  Remove before sending out.  Use to save settings.
    NSString *bundle = [[NSBundle mainBundle] pathForResource:@"LB1Deck" ofType:@"plist"];
    [fileManager removeItemAtPath:plistPath error:&error];
    [fileManager copyItemAtPath:bundle toPath:plistPath error:&error];
    appDel.currentDeckDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
    NSLog(@"%@", appDel.currentDeckDictionary);
    //put in error handling.
    
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
    
    //faux achievement
    if (cardCount == 5 || cardCount == 10 || cardCount == 15 || cardCount == 20) {
        //achievement alert
        [self achievementAlert];
    }
}

#pragma mark Achievement Handling
-(void)achievementAlert {
    NSLog(@"achievement");
    UIView *achAlert = [[UIView alloc] initWithFrame:CGRectMake(0, 460, 320, 68)]; //y-max is 480 - 20 because status bar is 20 points and moves origin down.
    achAlert.backgroundColor = [UIColor greenColor];
    UILabel *achLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 68)]; //same size as achAlert view so everything will be centered.
    achLabel.text = @"Achievement Alert";
    achLabel.textAlignment = NSTextAlignmentCenter;
    achLabel.backgroundColor = [UIColor clearColor];
    achLabel.textColor = [UIColor blackColor];
    [achLabel setFont:[UIFont fontWithName: @"Helvetica" size: 24.0f]];
    [achAlert addSubview:achLabel];
    [self.view addSubview:achAlert];
    [self showAchievementAlertView:achAlert];
}
-(void)showAchievementAlertView:(UIView*)achAlert {
    [UIView animateWithDuration:1
                          delay:0.05
                        options:  UIViewAnimationOptionAllowAnimatedContent
                     animations:^{
                         NSLog(@"%f,%f %f,%f",achAlert.center.x, achAlert.center.y, achAlert.frame.size.width,achAlert.frame.size.height);
                         achAlert.center = CGPointMake(achAlert.center.x, achAlert.center.y - achAlert.frame.size.height );
                     }
                     completion:^(BOOL finished){
                         NSLog(@"Animation Complete!");
                         [self hideAchievementAlertView:achAlert];
                     }];
}

-(void)hideAchievementAlertView:(UIView*)achAlert {
    [UIView animateWithDuration:1
                          delay:5.0
                        options:  UIViewAnimationOptionAllowAnimatedContent
                     animations:^{
                         NSLog(@"%f,%f %f,%f",achAlert.center.x, achAlert.center.y, achAlert.frame.size.width,achAlert.frame.size.height);

                         achAlert.center = CGPointMake(achAlert.center.x, achAlert.center.y + achAlert.frame.size.height );
                     }
                     completion:^(BOOL finished){
                         NSLog(@"Animation Complete!");
                         [self removeAchievementAlertView:achAlert];
                     }];
}

- (void)removeAchievementAlertView:(UIView*)achAlert
{
    [achAlert removeFromSuperview];
}
#pragma mark Events
-(void)workoutDone {
    NSTimer *myTimer = [NSTimer timerWithTimeInterval:2.5 target:self selector:@selector(loadSummaryView) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:myTimer forMode:NSDefaultRunLoopMode];
}
- (NSString*)updateClock {
    NSDate *timerDate = [NSDate date];//set timer date as seconds since beginning of time
    NSTimeInterval newTimeInterval = [timerDate timeIntervalSinceDate:_startDate];
    NSString *timeString = [self formattedStringForDuration:newTimeInterval];
    return timeString;
}
- (NSString*)formattedStringForDuration:(NSTimeInterval)duration
{
    NSInteger minutes = floor(duration/60);
    NSInteger seconds = round(duration - minutes * 60);
    return [NSString stringWithFormat:@"%d:%02d", minutes, seconds];
}
-(void)loadSummaryView {
    //total time
    NSString *totalTimeString = [self updateClock];
    
    //view setup
    UIView *summaryView = [[UIView alloc] initWithFrame:CGRectMake(0, 460, 320, 460)]; //y-max is 480 - 20 because status bar is 20 points and moves origin down.
    summaryView.backgroundColor = [UIColor grayColor];
    summaryView.tag = 1; //use to get
    UILabel *summaryLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 30, 260, 40)]; //same size as achAlert view so everything will be centered.
    summaryLabel.text = @"Summary View";
    summaryLabel.textAlignment = NSTextAlignmentCenter;
    summaryLabel.backgroundColor = [UIColor clearColor];
    summaryLabel.textColor = [UIColor blackColor];
    [summaryLabel setFont:[UIFont fontWithName: @"Helvetica" size: 24.0f]];
    [summaryView addSubview:summaryLabel];
    
    UILabel *totalTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 80, 260, 40)]; //same size as achAlert view so everything will be centered.
    totalTimeLabel.text = totalTimeString;
    totalTimeLabel.textAlignment = NSTextAlignmentCenter;
    totalTimeLabel.backgroundColor = [UIColor clearColor];
    totalTimeLabel.textColor = [UIColor blackColor];
    [totalTimeLabel setFont:[UIFont fontWithName: @"Helvetica" size: 24.0f]];
    [summaryView addSubview:totalTimeLabel];
    
    UIButton *summaryButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    summaryButton.backgroundColor = [UIColor whiteColor];
    summaryButton.frame = CGRectMake(80, 300, 160, 44);
    [summaryButton setTitle:@"Close" forState:UIControlStateNormal];
    summaryButton.titleLabel.textColor = [UIColor blueColor];
    summaryButton.titleLabel.center = summaryButton.center;
    [summaryButton.titleLabel setFont:[UIFont fontWithName: @"Helvetica" size: 12.0f]];

    [summaryButton addTarget:self action:@selector(hideSummaryView:) forControlEvents:UIControlEventTouchUpInside];
    [summaryView addSubview:summaryButton];
    [self.view addSubview:summaryView];
    
    [self showSummaryView:summaryView];
}
-(void)showSummaryView:(UIView*)myView {
    [UIView animateWithDuration:1
                          delay:0.05
                        options:  UIViewAnimationOptionAllowAnimatedContent
                     animations:^{
                         myView.center = CGPointMake(myView.center.x, myView.center.y - myView.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         NSLog(@"Animation Complete!");
                     }];
}

-(void)hideSummaryView:(UIView*)myView {
    myView = myView.superview;
    [UIView animateWithDuration:1
                          delay:1.0
                        options:  UIViewAnimationOptionAllowAnimatedContent
                     animations:^{
                         myView.center = CGPointMake(myView.center.x, myView.center.y + myView.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         NSLog(@"Animation Complete!");
                         [self removeAchievementAlertView:myView];
                     }];
}

#pragma mark Actions
- (IBAction)goButtonPressed:(id)sender {
    
    self.workoutHasBegun = YES;
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
    }
}

- (IBAction)swipeGesture:(id)sender {
    if (self.workoutHasBegun) {
        if (d.cardsRemaining > 0) {
            [self.d draw];
            [self updateTopCard];
        } else if (d.cardsRemaining <= 0) {
            self.cardSuitLabel.text = @"Done.";
            [self.stopWatchTimer invalidate];
            [self workoutDone];
        }
    }
}



@end
