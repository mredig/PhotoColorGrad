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
@property (nonatomic, readwrite) NSArray *orderedColors;

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
	_orderedColors = [NSArray array];
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

	for (size_t y = 0; y < imageHeight; y++) {
		for (size_t x = 0; x < imageWidth; x++) {
			size_t baseOffset = y * bytesPerRow + x * 4;

			uint8_t red, green, blue;
			red = bytes[baseOffset + 0];
			green = bytes[baseOffset + 1];
			blue = bytes[baseOffset + 2];
			REPImagePixel *pixel = [REPImagePixel pixelWithRed:red green:green blue:blue];

			if (![self pixelIsGreyscale:pixel]) {
				[self.pixels addObject:pixel];
			}
		}
		double percent = (double)y / (double)imageHeight;
		NSLog(@"%f complete", percent);
	}
	self.pixels = [self condensePixels:self.pixels withinThreshold:50];

	NSLog(@"%lu", (unsigned long)[self.pixels count]);
	self.orderedColors = [self.pixels allItemsInOrderOfCount];
	NSLog(@"pixels: %@", self.orderedColors);

	completion();
}

- (BOOL)pixelIsGreyscale:(REPImagePixel *)pixel {

	NSUInteger average = (NSUInteger)pixel.red + (NSUInteger)pixel.green + (NSUInteger)pixel.blue;
	average /= 3;

	REPImagePixel *grayPix = [REPImagePixel pixelWithRed:average green:average blue:average];
	
	return [grayPix distanceTo:pixel isWithin:15];
}

- (NSCountedSet<REPImagePixel *> *)condensePixels:(NSCountedSet<REPImagePixel *> *)pixels withinThreshold:(double)threshold {

	NSCountedSet *mergedPixels = [[NSCountedSet alloc] init];
	NSArray *orderArray = pixels.allItemsInOrderOfCount;

	for (int i = 0; i < orderArray.count; i++) {
		REPImagePixel *thisPixel = (REPImagePixel*)orderArray[i][0];
		NSUInteger pixelCount = [pixels countForObject:thisPixel];
		if (pixelCount == 0) {
			continue;
		}
		for (int j = i; j < orderArray.count; j++) {
			REPImagePixel *mergePixel = (REPImagePixel*)orderArray[j][0];
			NSUInteger mergePixelCount = [pixels countForObject:mergePixel];
			if ([thisPixel distanceTo:mergePixel isWithin:threshold]) {
				for (int k = 0; k < mergePixelCount; k++) {
					[pixels removeObject:mergePixel];
					[mergedPixels addObject:thisPixel];
				}
			}
		}
	}

	return mergedPixels;
}

- (BOOL)pixel:(REPImagePixel *)pixelA comparedTo:(REPImagePixel *)pixelB isWithin:(double) threshold {
	if ([pixelA isEqual:pixelB]) {
		return NO;
	}
	return [pixelA distanceTo:pixelB isWithin:threshold];
}

- (NSArray<UIColor *> *)colors {
	NSMutableArray *justColors = [NSMutableArray arrayWithCapacity:self.orderedColors.count];

	for (NSArray* colorTuple in self.orderedColors) {
		REPImagePixel *pixel = colorTuple[0];
		[justColors addObject:pixel.color];
	}
	return [justColors copy];
}

@end
