//
//  MapKitExampleViewController.h
//  MapKitExample
//
//  Created by Cory Wiles on 6/30/10.
//  Copyright Wiles, LLC 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Annotation.h"

#define kPhoenixLat 35.17939
#define kPhoenixLong -89.83051
#define kXBldgLat 35.15581
#define kXBldgLong -90.04616
/**
 * Change these values for region zooming when the map loads
 */
#define kDeltaLat 1.0f
#define kDeltaLong 1.0f

@interface MapKitExampleViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate, CLLocationManagerDelegate> {
  MKMapView *_mapView;
  Annotation *_newAnnotation;
  CLLocationManager *_locationManager;
}

@property (nonatomic, retain) MKMapView *mapView;
@property (nonatomic, retain) Annotation *newAnnotation;
@property (nonatomic, retain) CLLocationManager *locationManager;

- (void)setCurrentLocation:(CLLocation *)location;

@end

