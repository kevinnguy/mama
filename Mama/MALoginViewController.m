//
//  MALoginViewController.m
//  Mama
//
//  Created by Kevin Nguy on 8/14/14.
//  Copyright (c) 2014 Kevin Nguy. All rights reserved.
//

#import "MALoginViewController.h"

@interface MALoginViewController ()

@end

@implementation MALoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)loginButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"SegueToHome" sender:self];
}


@end
