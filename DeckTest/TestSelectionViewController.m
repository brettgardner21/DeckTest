//
//  TestSelectionViewController.m
//  DeckTest
//
//  Created by Nicholas Terry on 7/15/13.
//  Copyright (c) 2013 Brett Gardner. All rights reserved.
//

#import "TestSelectionViewController.h"

@interface TestSelectionViewController ()

@end

@implementation TestSelectionViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)unwindFromSegue:(UIStoryboardSegue*)sender {
}

@end
