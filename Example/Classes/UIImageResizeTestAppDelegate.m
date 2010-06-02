//
//  UIImageResizeTestAppDelegate.m
//  UIImageResizeTest
//
//  Created by Olivier on 28/05/10.
//  Copyright AliSoftware 2010. All rights reserved.
//

#import "UIImageResizeTestAppDelegate.h"

@implementation UIImageResizeTestAppDelegate

@synthesize window;
@synthesize viewController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {    

    // Override point for customization after application launch
	[window addSubview:viewController.view];
    [window makeKeyAndVisible];
}

- (void)dealloc {
    [window release];
    [super dealloc];
}

@end