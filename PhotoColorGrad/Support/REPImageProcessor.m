//
//  REPImageProcessor.m
//  PhotoColorGrad
//
//  Created by Michael Redig on 4/10/20.
//  Copyright © 2020 Red_Egg Productions. All rights reserved.
//

#import "REPImageProcessor.h"
#import <UIKit/UIKit.h>
#import "REPImagePixel.h"
#import "NSCountedSet+NSCountedSet_MostCommon.h"

@interface REPImageProcessor()

@property (nonatomic, readwrite) NSCountedSet<REPImagePixel *> *pixels;

@end

@implementation REPImageProcessor

- (instancetype)init {
	if (self = [super init]) {
		[self reset];
	}
	return self;
}

- (void)reset {
	_pixels = [NSCountedSet setWithArray:@[]];
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

	size_t imageWidth = CGImageGetWidth(cgImage);
	size_t imageHeight = CGImageGetHeight(cgImage);
	size_t bytesPerRow = CGImageGetBytesPerRow(cgImage);

	NSData *imageData = (__bridge_transfer NSData *)imageCfData;
	uint8_t *bytes = (uint8_t *)imageData.bytes;

	int count = 0;
	for (size_t y = 0; y < imageHeight; y++) {
		for (size_t x = 0; x < imageWidth; x++) {
			size_t baseOffset = y * bytesPerRow + x * 4;

			uint8_t red, green, blue;
			red = bytes[baseOffset + 0];
			green = bytes[baseOffset + 1];
			blue = bytes[baseOffset + 2];
			REPImagePixel *pixel = [REPImagePixel pixelWithRed:red green:green blue:blue];

			[self.pixels addObject:pixel];
			count += 1;
		}
		double percent = (double)y / (double)imageHeight;
		NSLog(@"%f complete", percent);
	}

	NSLog(@"%lu", (unsigned long)[self.pixels count]);
	NSLog(@"iterations: %d, %zu %zu", count, imageWidth, imageHeight);
	NSLog(@"pixels: %@", [self.pixels allItemsInOrderOfCount]);

	completion();
}

@end
