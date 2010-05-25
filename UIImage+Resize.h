//
//  UIImage+Resize.h
//
//  Created by Olivier on 02/07/09.
//  Copyright 2009 AliSoftware. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIImage(ResizeCategory)
-(UIImage*)resizedImageToSize:(CGSize)dstSize;
-(UIImage*)resizedImageToFitInSize:(CGSize)boundingSize scaleIfSmaller:(BOOL)scale;
@end
