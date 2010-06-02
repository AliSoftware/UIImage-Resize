//
//  UIImageResizeTestAppDelegate.h
//  UIImageResizeTest
//
//  Created by Olivier on 28/05/10.
//  Copyright AliSoftware 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageResizeViewController.h"

@interface UIImageResizeTestAppDelegate : NSObject <UIApplicationDelegate>
{
    UIWindow *window;
	ImageResizeViewController* viewController;
}
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ImageResizeViewController* viewController;
@end

