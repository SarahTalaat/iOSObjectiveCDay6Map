//
//  ViewController.m
//  iOSObjectiveCDay6
//
//  Created by Sara Talat on 20/04/2024.
//

#import "ViewController.h"
#import "CustomAnnotation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    // Do any additional setup after loading the view.
    self.mapView.rotateEnabled = NO;
    self.mapView.zoomEnabled = YES ;
    self.mapView.delegate = self;
    
    //Location manager
    
    _locationManager = [CLLocationManager new];
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [_locationManager setDistanceFilter:kCLHeadingFilterNone];
    self.locationManager.delegate = self;
    
    [_locationManager startUpdatingLocation];
    
    self.mapView.showsUserLocation = YES;
    
}
//atomic:
/*
 Thread safe
 one at a time
 lama el thread t5ls sho8laha 7sm7 lthread ltanya t acces el property deh and so on
 */

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    printf("regionWillChangeAnimated\n");
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    printf("regionDidChangeAnimated\n");
}

//

- (IBAction)addAnnotation:(id)sender {
    
    for (id<MKAnnotation> annotation in _mapView.annotations) {
        [_mapView removeAnnotation:annotation];
    }
    CGPoint touchPoint = [sender locationInView:self.mapView];
    CLLocationCoordinate2D touchLocation = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    CustomAnnotation *annotation = [CustomAnnotation new];
    annotation.coordinate = touchLocation;
    annotation.title = @"Current Location";
    [_locationManager requestWhenInUseAuthorization];
    
    [self.mapView addAnnotation:annotation];
    
}
//what is retain cycle?
//how to avoid or solve it?
//example

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"userLocation"];
        annotationView.image = [UIImage imageNamed:@"car_icon"];
        annotationView.frame = CGRectMake(0, 0, 30, 30);
        annotationView.canShowCallout = NO;
        return annotationView;
    }
    
    return nil; // Return nil for other annotations
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading{
    
    printf("didUpdateHeading\n");
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    //only new update
    printf("didUpdateUserLocation\n");
}

// Implement CLLocationManagerDelegate method to handle location updates
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *currentLocation = [locations lastObject];
    
    // Center the map at the user's current location
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(currentLocation.coordinate, 500, 500); // 500 meters around the user
    [self.mapView setRegion:region animated:YES];
    
    // Stop updating location to save battery
    [self.locationManager stopUpdatingLocation];
}

// Implement CLLocationManagerDelegate method to handle location authorization status changes
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        // Location authorization granted, start updating location
        [self.locationManager startUpdatingLocation];
    }
}


//
@end
