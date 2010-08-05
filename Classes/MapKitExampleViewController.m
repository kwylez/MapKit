//
//  MapKitExampleViewController.m
//  MapKitExample
//
//  Created by Cory Wiles on 6/30/10.
//  Copyright Wiles, LLC 2010. All rights reserved.
//

#import "MapKitExampleViewController.h"

@implementation MapKitExampleViewController

@synthesize mapView         = _mapView;
@synthesize newAnnotation   = _newAnnotation;
@synthesize locationManager = _locationManager;

- (void)dealloc {
  
  _mapView.delegate         = nil;
  _locationManager.delegate = nil;

  [_mapView release];
  [_newAnnotation release];
  [_locationManager release];
  
  [super dealloc];
}

- (void)viewDidAppear:(BOOL)animated {
  
  [super viewDidAppear:animated];
  
  self.locationManager = [[[CLLocationManager alloc] init] autorelease];
  
  self.locationManager.delegate        = self;
  self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
  
  [self.locationManager startUpdatingLocation];
  
  self.mapView                   = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
  self.mapView.delegate          = self;
  self.mapView.autoresizingMask  = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  self.mapView.showsUserLocation = YES;
  
  self.view = self.mapView;
  
  NSMutableArray *poiAnnotationArray  = [[NSMutableArray alloc] init];
  NSMutableArray *selected = [[NSMutableArray alloc] init];
  
  CLLocationDegrees poiOneLat  = kPhoenixLat;
  CLLocationDegrees poiOneLong = kPhoenixLong;
  
  CLLocation *firstLocation = [[CLLocation alloc] initWithLatitude:poiOneLat longitude:poiOneLong];
  
  self.newAnnotation = [Annotation annotationWithCoordinate:firstLocation.coordinate];
  
  [firstLocation release];
  
  self.newAnnotation.title    = @"Phoenix Office Title";
  self.newAnnotation.subtitle = @"Phoenix Office SubTitle";
  
  [poiAnnotationArray addObject:self.newAnnotation];
  
  [selected addObject:self.newAnnotation];
  
  self.newAnnotation = nil;
  
  CLLocationDegrees poiTwoLat  = kXBldgLat;
  CLLocationDegrees poiTwoLong = kXBldgLong;
  
  CLLocation *secondLocation = [[CLLocation alloc] initWithLatitude:poiTwoLat longitude:poiTwoLong];
  
  self.newAnnotation = [Annotation annotationWithCoordinate:secondLocation.coordinate];
  
  [secondLocation release];
  
  self.newAnnotation.title    = @"XBldg Title";
  self.newAnnotation.subtitle = @"XBldg SubTitle";
  
  [poiAnnotationArray addObject:self.newAnnotation];
  
  [selected addObject:self.newAnnotation];
  
  self.newAnnotation = nil;
  
  [self.mapView addAnnotations:poiAnnotationArray];
  
  /**
   * This should have called out the first annotation in the array?
   */
  self.mapView.selectedAnnotations = selected;
  
  [selected release];
  
  [poiAnnotationArray release];
}

- (void)viewDidLoad {
  
  CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:self.mapView.userLocation.coordinate.latitude 
                                                           longitude:self.mapView.userLocation.coordinate.longitude];
  
  [self setCurrentLocation:currentLocation];
  
  [currentLocation release];
  [super viewDidLoad];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return YES;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

#pragma mark MapView delegate/datasourec methods
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
  
  MKPinAnnotationView *view = nil; // return nil for the current user location
  
  if (annotation != mapView.userLocation) {
    
    view = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"identifier"];
    
    if (nil == view) {
      
      view = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"identifier"] autorelease];
      view.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    }
    
    [view setPinColor:MKPinAnnotationColorPurple];
    [view setCanShowCallout:YES];
    [view setAnimatesDrop:YES];
    
  } else {
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:mapView.userLocation.coordinate.latitude 
                                                      longitude:mapView.userLocation.coordinate.longitude];
    [self setCurrentLocation:location];
    [view setPinColor:MKPinAnnotationColorGreen];
    [view setCanShowCallout:YES];
    [view setAnimatesDrop:YES];
  }
  return view;
}

#pragma mark -
#pragma mark CoreLocation Delegate Methods
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
  [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
  [self.locationManager stopUpdatingLocation];
}

#pragma mark -
#pragma mark Custom Methods
- (void)setCurrentLocation:(CLLocation *)location {
  
  MKCoordinateRegion region = {{0.0f, 0.0f}, {0.0f, 0.0f}};
  
  region.center = location.coordinate;
  
  region.span.longitudeDelta = kDeltaLat;
  region.span.latitudeDelta  = kDeltaLong;
  
  [self.mapView setRegion:region animated:YES];
  [self.mapView regionThatFits:region];
}

@end
