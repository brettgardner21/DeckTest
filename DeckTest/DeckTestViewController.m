//
//  DeckTestViewController.m
//  DeckTest
//
//  Created by Brett Gardner on 3/10/13.
//  Copyright (c) 2013 Brett Gardner. All rights reserved.
//


#import "DeckTestViewController.h"
#import "Workout.h"
#import "Deck.h"
#import "Exercise.h"
#import "Card.h"
#import "NSMutableArray_Shuffle.h"

@interface DeckTestViewController ()

@property (strong, nonatomic) NSTimer *stopWatchTimer; // Store the timer that fires after a certain time
@property (strong, nonatomic) NSDate *startDate; // Stores the date of the click on the start button
@property NSTimeInterval elapsedTime; //Elapsed Time
@property Deck *testDeck;

@end


@implementation DeckTestViewController


@synthesize subView;

- (void)viewDidLoad
{
    //set elapsed time at 0;
    self.elapsedTime = 0;

    //Let's test parse
    PFQuery *query = [Deck query];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            Deck *firstDeck = [objects objectAtIndex:0];
            self.deckLabel.text = firstDeck.name;
            
            
            NSMutableArray *cards = [firstDeck getCards];
            [cards shuffle];
            for (Card *card in cards){
                [self addCard:card];
            }
            
            _testDeck = firstDeck;
            
            //get all cards for the test deck
//            PFQuery *query2 = [PFQuery queryWithClassName:@"Card"];
//            
//            // Follow relationship
//            [query2 whereKey:@"deck" equalTo:firstDeck];
//            [query2 includeKey:@"exercise"];
//            
//            [query2 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//                if (!error) {
//                    NSMutableArray *cards = [(NSArray *)objects mutableCopy];
//
//                    
//                }
//            }];
        }
    }];
    

    
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
- (void)addCard:(Card *)card
{
    //Make a frame for view to be loaded in
    CGRect frame = CGRectMake(0, 0, 240, 300);
    //Initialize subview
    subView = [[UIView alloc] initWithFrame:frame];
    
    //Set background color so you can see it
    subView.backgroundColor = [UIColor redColor];
    
    //lets see if we can add a gesture recognizer
    subView.userInteractionEnabled = YES;
    UIPanGestureRecognizer *pgr = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    pgr.delegate = self;
    [subView addGestureRecognizer:pgr];
    
    //Let's add a label for the card number
    UILabel *cardLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 180, 30)];
    [subView addSubview:cardLabel];
    
    NSString *s = card.faceValue;
    s = [s stringByAppendingString:@" "];
    s = [s stringByAppendingString:card.suit];
    
    cardLabel.text = s;
    
    UILabel *exLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 180, 30)];
    [subView addSubview:exLabel];
    
    NSString *exercise = [NSString stringWithFormat:@"%d", card.reps];
    exercise = [exercise stringByAppendingString:@" "];
    exercise = [exercise stringByAppendingString:card.exercise.name];
    
    exLabel.text = exercise;
    


    //position
    subView.center = self.view.center;
    
    //Add subView to view
    [self.view addSubview:subView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    //Constants
    float slideLength = .25; //less than duration due to friction.  will go half as far with no friction
    CGPoint center = self.view.center;
    float startX = center.x;
    float startY = center.y;
    
    
    
    //Get the Starting point so we can reset
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        startX = recognizer.view.center.x;
        startY = recognizer.view.center.y;
    }
    
    //translation is how far my touch traveled in the interval
    CGPoint translation = [recognizer translationInView:self.view];
    
    //move the center of the view to the center + translation
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    
    
    
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view]; //always reset the translation so it's not cumulative
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        Boolean completed = true;
        
        CGPoint velocity = [recognizer velocityInView:self.view];
        CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y)); //hypotenuse velocity
        
        CGPoint finalPoint = CGPointMake(recognizer.view.center.x + (velocity.x * slideLength),recognizer.view.center.y + (velocity.y * slideLength));
        
        NSLog(@"velocity: %f", magnitude);
        
        //threshold for not returning to start
        if (magnitude < 1750){
            finalPoint.x = startX;
            finalPoint.y = startY;
            completed = false;
        }

        
        [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                recognizer.view.center = finalPoint;
            }
            completion:^(BOOL finished){
                //If completed card, elimate from view.
                if(completed){
                    [recognizer.view removeFromSuperview];
                    NSLog(@"Removed Card");
                }
                
            }];
        
    }
    
}
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

- (IBAction)onStartPressed:(id)sender {
    
    self.startDate = [NSDate date];
    
    // Create the stop watch timer that fires every 100 ms
    self.stopWatchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                           target:self
                                                         selector:@selector(updateTimer)
                                                         userInfo:nil
                                                          repeats:YES];
    //Disable the start button
    self.startButton.enabled = false;
    [self.startButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    
}

- (IBAction)onStopPressed:(id)sender {
    self.elapsedTime += [[NSDate date] timeIntervalSinceDate:self.startDate];
    [self.stopWatchTimer invalidate];
    self.stopWatchTimer = nil;
    //[self updateTimer];
    
    //Enable the start button
    self.startButton.enabled = true;
}

- (IBAction)onResetPressed:(id)sender {
    
    [self.stopWatchTimer invalidate];
    self.stopWatchTimer = nil;
    //[self updateTimer];
    
    //Enable the start button
    self.startButton.enabled = true;
    
    //Let's Test adding a Workout with a Deck.  T
    Workout *workout = [[Workout alloc] init];
    workout.deck = _testDeck;
    workout.duration = _elapsedTime;

    //Save the new post
    [workout saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            self.timerLabel.text = @"Saved";
        }
    }];
    

    //Reset elapsedTime
    self.elapsedTime = 0;
    
    
    
}
@end
