//
//  REPImageProcessor.m
//  PhotoColorGrad
//
//  Created by Michael Redig on 4/10/20.
//  Copyright © 2020 Red_Egg Productions. All rights reserved.
//

#import "REPImageProcessor.h"
#import <UIKit/UIKit.h>


@implementation REPImageProcessor

- (instancetype)init {
	return (self = [super init]);
}

- (void)loadImage:(UIImage *)image completionHandler:(REPImageProcessorCompletionHandler)completion {

	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		[self internalLoadImage:image completionHandler:completion];
	});
}

- (void)internalLoadImage:(UIImage *)image completionHandler:(REPImageProcessorCompletionHandler)completion {
	CGImageRef cgImage = image.CGImage;

	CGDataProviderRef imageDataProvider = CGImageGetDataProvider(cgImage);
	CFDataRef imageCfData = CGDataProviderCopyData(imageDataProvider);

	NSData *imageData = (__bridge_transfer NSData *)imageCfData;
	uint8_t *bytes = (uint8_t *)imageData.bytes;

	for (uint i = 0; i < 20; i++) {
		NSLog(@"%d", bytes[i]);
	}

	CGImageRelease(cgImage);
	CGDataProviderRelease(imageDataProvider);

	completion();
}

@end
