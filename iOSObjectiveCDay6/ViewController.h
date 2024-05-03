//
//  ViewController.h
//  iOSObjectiveCDay6
//
//  Created by Sara Talat on 20/04/2024.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <MKMapViewDelegate,MKAnnotation,CLLocationManagerDelegate>

- (IBAction)addAnnotation:(id)sender;
 
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString* subtitle;
@property CLLocationManager *locationManager;
@end

