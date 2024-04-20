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
    self.mapView.zoomEnabled = NO ;
    self.mapView.delegate = self;
    
    //Location manager
    
    _locationManager = [CLLocationManager new];
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [_locationManager setDistanceFilter:kCLHeadingFilterNone];
    self.locationManager.delegate = self;
    
    [_locationManager startUpdatingLocation];
    
}

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
    annotation.title = @"MAD Alex";
    [_locationManager requestWhenInUseAuthorization];
    
    [self.mapView addAnnotation:annotation];
    
}


- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading{
    
    printf("didUpdateHeading\n");
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    //allUpdates
    printf("didUpdateLocations\n");
}
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    //only new update
    printf("didUpdateUserLocation\n");
}


//
@end
