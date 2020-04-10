//
//  REPImagePixel.m
//  PhotoColorGrad
//
//  Created by Michael Redig on 4/10/20.
//  Copyright © 2020 Red_Egg Productions. All rights reserved.
//

#import "REPImagePixel.h"

@implementation REPImagePixel

- (instancetype)initWithRed:(uint8_t)red green:(uint8_t)green blue:(uint8_t)blue alpha:(uint8_t)alpha {
	if (self = [super init]) {
		_red = red;
		_green = green;
		_blue = blue;
		_alpha = alpha;
	}
	return self;
}

+ (REPImagePixel *)pixelWithRed:(uint8_t)red green:(uint8_t)green blue:(uint8_t)blue alpha:(uint8_t)alpha {
	return [[REPImagePixel alloc] initWithRed:red green:green blue:blue alpha:alpha];
}

+ (REPImagePixel *)pixelWithRed:(uint8_t)red green:(uint8_t)green blue:(uint8_t)blue {
	return [REPImagePixel pixelWithRed:red green:green blue:blue alpha:255];
}

@end
