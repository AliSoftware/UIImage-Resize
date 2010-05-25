//
//  UIImage+Resize.m
//
//  Created by Olivier HALLIGON on 12/08/09.
//  Copyright 2009 AliSoftware. All rights reserved.
//

#import "UIImage+Resize.h"

@implementation UIImage (ResizeCategory)

-(UIImage*)resizedImageToSize:(CGSize)dstSize
{
	//NSLog(@"resizing image from %@ to %@" , NSStringFromCGSize(self.size), NSStringFromCGSize(dstSize));
	
	// Take the imageOrientation into account
	// NOTE: when taking a pic from the camera, the iPhone is supposed to be held left (so the photo is taken landscape as in a classic camera)
	CGAffineTransform tr = CGAffineTransformIdentity;
	CGRect dstRect = CGRectMake(0,0,dstSize.width,dstSize.height);
	switch (self.imageOrientation)
	{
		case UIImageOrientationLeft: // iPhone oriented Down
			tr = CGAffineTransformMakeRotation(M_PI_2);
			break;
		case UIImageOrientationUp: // iPhone oriented Left
			tr = CGAffineTransformIdentity;
			break;
		case UIImageOrientationRight: // iPhone oriented Up
			tr = CGAffineTransformMakeRotation(-M_PI_2);
			break;
		case UIImageOrientationDown: // iPhone oriented Right
			tr = CGAffineTransformMakeRotation(M_PI);
			break;
		default:
			break;
	}
	
	if (CGSizeEqualToSize(dstSize, self.size) || CGSizeEqualToSize(dstSize, CGSizeZero) ){
		// avoid useless resizing
		return self;
	}
	
	// Create the bitmap context to draw the thumbnail into
	CGImageRef img = [self CGImage];
	
	CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(img);
	CGImageAlphaInfo alphaInfo = bitmapInfo & kCGBitmapAlphaInfoMask;
	if (alphaInfo == kCGImageAlphaFirst) alphaInfo = kCGImageAlphaPremultipliedFirst;
	if (alphaInfo == kCGImageAlphaLast)  alphaInfo = kCGImageAlphaPremultipliedLast;
	bitmapInfo = (bitmapInfo & ~kCGBitmapAlphaInfoMask) | alphaInfo; // reinject modified alphaInfo in bitmapInfo
	CGColorSpaceRef cs = CGImageGetColorSpace(img);
	
	//void* bufferImage = malloc(self.size.width * self.size.height * 4);
	CGContextRef ctx = CGBitmapContextCreate(/*bufferImage*/NULL,
											 dstSize.width,		// width
											 dstSize.height,		// height
											 8, 0, // nbits per component, bytes per row
											 cs, // colorspace
											 bitmapInfo
											 );
	
	
	CGContextConcatCTM(ctx, CGAffineTransformMakeTranslation(dstSize.width/2, dstSize.height/2));
	CGContextConcatCTM(ctx, tr);
	CGContextConcatCTM(ctx, CGAffineTransformMakeTranslation(-dstSize.width/2, -dstSize.height/2));
	dstRect = CGRectApplyAffineTransform(dstRect, CGContextGetCTM(ctx));
	
	// draw the image in thumbnail size
	CGContextDrawImage(ctx, CGRectMake(dstRect.origin.x,dstRect.origin.y,dstRect.size.width, dstRect.size.height), img);
	
	// gather the corresponding UIImage
	CGImageRef	ref = CGBitmapContextCreateImage(ctx);
	UIImage*	thumb = [UIImage imageWithCGImage:ref];
	CGImageRelease(ref);
	
	// done.
	CGContextRelease(ctx);	// ok if NULL
	//free(bufferImage);
	
	return thumb;
}

-(UIImage*)resizedImageToFitInSize:(CGSize)boundingSize scaleIfSmaller:(BOOL)scale
{
	// Calculer le CGRect miniature pour garder l'aspect-ratio
	CGSize dstSize = CGSizeZero;
	
	if ( !scale && (self.size.width < boundingSize.width) && (self.size.height < boundingSize.height) ) {
		//NSLog(@"Image is smaller, and we asked not to scale it in this case (scaleIfSmaller:NO)");
		return self;
	} else {		
		CGFloat wRatio = boundingSize.width / self.size.width;
		CGFloat hRatio = boundingSize.height / self.size.height;
		
		if (wRatio < hRatio) {
			//NSLog(@"Width imposed, Height scaled ; ratio = %f",wRatio);
			dstSize = CGSizeMake(boundingSize.width, self.size.height * wRatio);
		} else {
			//NSLog(@"Height imposed, Width scaled ; ratio = %f",hRatio);
			dstSize = CGSizeMake(self.size.width * hRatio, boundingSize.height);
		}
	}
	
	return [self resizedImageToSize:dstSize];
}

@end