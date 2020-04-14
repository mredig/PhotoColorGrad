//
//  REPSparkleView.m
//  SparkleProgress
//
//  Created by Michael Redig on 4/14/20.
//  Copyright © 2020 Red_Egg Productions. All rights reserved.
//

#import "REPSparkleView.h"
#import "REPSparkleScene.h"

@interface REPSparkleView()

@property (nonatomic, nonnull) REPSparkleScene *sparkleScene;

@end

@implementation REPSparkleView

- (instancetype)initWithCoder:(NSCoder *)coder {
	if (self = [super initWithCoder:coder]) {
		[self commonInit];
	}
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		[self commonInit];
	}
	return self;
}

- (void)commonInit {
	_sparkleScene = [[REPSparkleScene alloc] initWithSize:self.bounds.size];
	[self presentScene:self.sparkleScene];
	self.opaque = NO;
}

- (void)layoutSubviews {
	[super layoutSubviews];
	self.sparkleScene.size = self.bounds.size;
}


// MARK: - Properties
- (void)setProgress:(CGFloat)progress {
	self.sparkleScene.progress = progress;
}

- (CGFloat)progress {
	return self.sparkleScene.progress;
}

- (void)setBackgroundStrength:(CGFloat)backgroundStrength {
	self.sparkleScene.backgroundStrength = backgroundStrength;
	if (self.backgroundStrength == 1.0) {
		self.opaque = YES;
	} else {
		self.opaque = NO;
	}
}

- (CGFloat)backgroundStrength {
	return self.sparkleScene.backgroundStrength;
}

- (void)setYPosition:(CGFloat)yPosition {
	self.sparkleScene.yPosition = yPosition;
}

- (CGFloat)yPosition {
	return self.sparkleScene.yPosition;
}

- (void)setAnimationSpeed:(CGFloat)animationSpeed {
	self.sparkleScene.animationSpeed = animationSpeed;
}

- (CGFloat)animationSpeed {
	return self.sparkleScene.animationSpeed;
}


@end
