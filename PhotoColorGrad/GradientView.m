//
//  GradientView.m
//  PhotoColorGrad
//
//  Created by Michael Redig on 4/11/20.
//  Copyright © 2020 Red_Egg Productions. All rights reserved.
//

#import "GradientView.h"

@interface GradientView()

@property (nonatomic, readwrite) CAGradientLayer *gradientLayer;
@property (nonatomic, readwrite) NSArray<UIColor *> *internalColors;

@end

@implementation GradientView

- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		[self commonInit];
	}
	return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
	if (self = [super initWithCoder:coder]) {
		[self commonInit];
	}
	return self;
}

- (void)commonInit {
	_gradientLayer = [CAGradientLayer layer];
	NSArray<UIColor *> *internalColors = @[[UIColor clearColor]];
	[self setColors:internalColors];

	[self.layer insertSublayer:self.gradientLayer atIndex:0];

	self.gradientLayer.frame = self.layer.bounds;
	self.gradientLayer.startPoint = CGPointZero;
	self.gradientLayer.endPoint = CGPointMake(1, 0);
}

- (NSArray<UIColor *> *)colors {
	return [self.internalColors copy];
}

- (void)setColors:(NSArray<UIColor *> *)colors {
	self.internalColors = colors;
	NSMutableArray *colorBuilder = [NSMutableArray arrayWithCapacity:colors.count];
	for (int i = 0; i < colors.count; i++) {
		[colorBuilder addObject:(id)[colors[i] CGColor]];
	}
	self.gradientLayer.colors = [colorBuilder copy];
}

@end
