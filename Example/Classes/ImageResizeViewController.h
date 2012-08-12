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

@property (nonatomic, retain) IBOutlet UIImageView* originalImageView;
@property (nonatomic, retain) IBOutlet UIImageView* scaledImageViewH;
@property (nonatomic, retain) IBOutlet UIImageView* scaledImageViewV;
@property (nonatomic, retain) UIImage* srcImage;

-(IBAction)pickFromLibrary;
-(IBAction)pickFromCamera;
@end
