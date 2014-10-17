//
//  MAMapViewController.m
//  Mama
//
//  Created by Kevin Nguy on 8/14/14.
//  Copyright (c) 2014 Kevin Nguy. All rights reserved.
//

#import "MAMapViewController.h"

@interface MAMapViewController () <CLLocationManagerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGesture;

@end

@implementation MAMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mapView.showsUserLocation = YES;
    self.mapView.showsBuildings = YES;
    self.mapView.showsPointsOfInterest = YES;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = kCLLocationAccuracyKilometer;
    [self.locationManager startUpdatingLocation];
    
    self.longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressTouchUp:)];

    self.longPressGesture.delegate = self;
    self.longPressGesture.minimumPressDuration = 0.1f;

    [self.mapView addGestureRecognizer:self.longPressGesture];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    MKCoordinateSpan span = MKCoordinateSpanMake(0.005f, 0.005f);
    MKCoordinateRegion region = MKCoordinateRegionMake(newLocation.coordinate, span);
    
    [self.mapView setRegion:region animated:YES];
    [self.mapView regionThatFits:region];
    
    self.mapView.zoomEnabled = NO;
}

- (void)longPressTouchUp:(UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded) {
        NSLog(@"awesoem");
        
//        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
//        [annotation setCoordinate:self.mapView.centerCoordinate];
//        [annotation setTitle:@"Title"]; //You can set the subtitle too
//        [self.mapView addAnnotation:annotation];
        
        [self dismissViewControllerAnimated:YES completion:^{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%f, %f", self.mapView.centerCoordinate.latitude, self.mapView.centerCoordinate.longitude]
                                                                message:nil
                                                               delegate:nil
                                                      cancelButtonTitle:@"Okay"
                                                      otherButtonTitles:nil];
            [alertView show];
        }];
    }
}


@end
