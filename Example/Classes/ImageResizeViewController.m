//
//  ImageResizeViewController.m
//  UIImageResizeTest
//
//  Created by Olivier on 28/05/10.
//  Copyright 2010 AliSoftware. All rights reserved.
//

#import "ImageResizeViewController.h"
#import "UIImage+Resize.h"

@implementation ImageResizeViewController
@synthesize srcImage;

-(IBAction)pickFromLibrary
{
	UIImagePickerController* ipc = [[UIImagePickerController alloc] init];
	ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	ipc.delegate = self;
	[self presentModalViewController:ipc animated:YES];
	[ipc release];
}

-(IBAction)pickFromCamera
{
	UIImagePickerController* ipc = [[UIImagePickerController alloc] init];
	ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
	ipc.delegate = self;
	[self presentModalViewController:ipc animated:YES];
	[ipc release];	
}
	 

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	self.srcImage = [info objectForKey:UIImagePickerControllerOriginalImage];
	[picker dismissModalViewControllerAnimated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
	NSLog(@"Updating interface");
	if (!self.srcImage) return;
	
	NSLog(@"Original image (%@): %@",self.srcImage,NSStringFromCGSize(self.srcImage.size));
	originalImageView.image = self.srcImage;
	
	UIImage* scaledImgH = [self.srcImage resizedImageToFitInSize:scaledImageViewH.bounds.size scaleIfSmaller:NO];
	NSLog(@"Scaled image H (%@): %@",scaledImgH,NSStringFromCGSize(scaledImgH.size));
	scaledImageViewH.image = scaledImgH;

	UIImage* scaledImgV = [self.srcImage resizedImageToFitInSize:scaledImageViewV.bounds.size scaleIfSmaller:NO];
	NSLog(@"Scaled image V (%@): %@",scaledImgV,NSStringFromCGSize(scaledImgV.size));
	scaledImageViewV.image = scaledImgV;
}

@end
