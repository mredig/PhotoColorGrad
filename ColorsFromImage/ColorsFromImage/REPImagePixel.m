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

- (double)distanceTo:(REPImagePixel *)pixel {
	double r1, g1, b1, r2, g2, b2;
	r1 = (double)self.red;
	g1 = (double)self.green;
	b1 = (double)self.blue;
	r2 = (double)pixel.red;
	g2 = (double)pixel.green;
	b2 = (double)pixel.blue;

	double reds = r1 - r2;
	double greens = g1 - g2;
	double blues = b1 - b2;
	reds *= reds;
	greens *= greens;
	blues *= blues;

	return sqrt(reds + greens + blues);
}

- (BOOL)distanceTo:(REPImagePixel *)pixel isWithin:(double)threshold {
	double r1, g1, b1, r2, g2, b2;
	r1 = (double)self.red;
	g1 = (double)self.green;
	b1 = (double)self.blue;
	r2 = (double)pixel.red;
	g2 = (double)pixel.green;
	b2 = (double)pixel.blue;

	double reds = r1 - r2;
	double greens = g1 - g2;
	double blues = b1 - b2;
	reds *= reds;
	greens *= greens;
	blues *= blues;

	return (reds + greens + blues) < (threshold * threshold);
}

// MARK: - Properties
- (UIColor *)color {
	double r, g, b, a;
	r = (CGFloat)self.red;
	g = (CGFloat)self.green;
	b = (CGFloat)self.blue;
	a = (CGFloat)self.alpha;

	r /= 255.0;
	g /= 255.0;
	b /= 255.0;
	a /= 255.0;

	return [UIColor colorWithRed:r green:g blue:b alpha:a];
}

// MARK: - Conformances
- (NSUInteger)hash {
	uint32_t red = (uint32_t)_red << 24;
	uint32_t green = (uint32_t)_green << 16;
	uint32_t blue = (uint32_t)_blue << 8;
	uint32_t alpha = (uint32_t)_alpha;
	return (NSUInteger)red | green | blue | alpha;
}

- (BOOL)isEqual:(id)other {
	if (other == self) {
		return YES;
	} else {
		if ([other isKindOfClass:[REPImagePixel class]]) {
			REPImagePixel *otherPixel = (REPImagePixel *)other;
			return otherPixel.red == self.red &&
				otherPixel.green == self.green &&
				otherPixel.blue == self.blue &&
				otherPixel.alpha == self.alpha;
		} else {
			return NO;
		}
	}
}

- (NSString *)debugDescription {
	return [NSString stringWithFormat:@"<%@: %p> %@", [self class], self, self.description];
}


- (NSString *)description {
	return [NSString stringWithFormat:@"red: %d, green: %d, blue: %d, alpha: %d",  self.red, self.green, self.blue, self.alpha];
}

- (id)copyWithZone:(NSZone *)zone {
	REPImagePixel *pixelCopy = [[[self class] allocWithZone:zone] init];
	if (pixelCopy) {
		pixelCopy.red = self.red;
		pixelCopy.green = self.green;
		pixelCopy.blue = self.blue;
		pixelCopy.alpha = self.alpha;
	}
	return pixelCopy;
}

@end
