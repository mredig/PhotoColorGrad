//
//  REPImagePixel.h
//  PhotoColorGrad
//
//  Created by Michael Redig on 4/10/20.
//  Copyright © 2020 Red_Egg Productions. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface REPImagePixel : NSObject

@property (nonatomic) uint8_t red;
@property (nonatomic) uint8_t green;
@property (nonatomic) uint8_t blue;
@property (nonatomic) uint8_t alpha;

- (instancetype)initWithRed:(uint8_t)red green:(uint8_t)green blue:(uint8_t)blue alpha:(uint8_t)alpha;

+ (REPImagePixel *)pixelWithRed:(uint8_t)red green:(uint8_t)green blue:(uint8_t)blue alpha:(uint8_t)alpha;
+ (REPImagePixel *)pixelWithRed:(uint8_t)red green:(uint8_t)green blue:(uint8_t)blue;

@end

NS_ASSUME_NONNULL_END
