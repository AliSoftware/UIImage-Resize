//
//  ImageResizeViewController.h
//  UIImageResizeTest
//
//  Created by Olivier on 28/05/10.
//  Copyright 2010 AliSoftware. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ImageResizeViewController : UIViewController
	<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
	IBOutlet UIImageView* originalImageView;
	IBOutlet UIImageView* scaledImageViewH;
	IBOutlet UIImageView* scaledImageViewV;
	
	UIImage* srcImage;
}
@property(nonatomic, retain) UIImage* srcImage;
-(IBAction)pickFromLibrary;
-(IBAction)pickFromCamera;
@end
