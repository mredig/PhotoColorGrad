//
//  REPPixelCounter.h
//  PhotoColorGrad
//
//  Created by Michael Redig on 4/11/20.
//  Copyright © 2020 Red_Egg Productions. All rights reserved.
//

#import <Foundation/Foundation.h>
@class REPImagePixel;

NS_ASSUME_NONNULL_BEGIN

@interface REPPixelCounter : NSObject

@property (nonatomic, readonly) NSDictionary<REPImagePixel *, NSNumber *> *pixelCounts;
@property (nonatomic, readonly) NSArray<REPImagePixel *> *pixels;
@property (nonatomic, readonly) NSArray<REPImagePixel *> *pixelsInOrder;

- (instancetype)init;

- (void)addPixelToPixels:(REPImagePixel *)pixel;
- (void)addPixelToPixels:(REPImagePixel *)pixel times:(NSNumber *)count;
/// Removes a pixel from counting
/// @param pixel pixel object to decrement
/// @return returns the number of times the pixel was removed
- (NSUInteger)removePixelFromPixels:(REPImagePixel *)pixel;
/// Removes a pixel from counting
/// @param pixel pixel object to decrement
/// @param count how many times to decrement
/// @return returns the number of times the pixel was removed
- (NSUInteger)removePixelFromPixels:(REPImagePixel *)pixel times:(NSNumber *)count;
- (NSUInteger)countForPixel:(REPImagePixel *)pixel;

@end

NS_ASSUME_NONNULL_END
