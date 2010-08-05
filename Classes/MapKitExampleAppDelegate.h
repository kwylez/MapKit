//
//  MapKitExampleAppDelegate.h
//  MapKitExample
//
//  Created by Cory Wiles on 6/30/10.
//  Copyright Wiles, LLC 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MapKitExampleViewController;

@interface MapKitExampleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MapKitExampleViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MapKitExampleViewController *viewController;

@end

