//
//  CustomAnnotation.h
//  iOSObjectiveCDay6
//
//  Created by Sara Talat on 20/04/2024.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomeAnnotation : NSObject <MKMapViewDelegate>

@property (nonatomic) CLLocationCoordinate2D coordinate;


@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end

NS_ASSUME_NONNULL_END
