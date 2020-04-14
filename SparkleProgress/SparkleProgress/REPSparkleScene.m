//
//  REPSparkleScene.m
//  SparkleProgress
//
//  Created by Michael Redig on 4/14/20.
//  Copyright © 2020 Red_Egg Productions. All rights reserved.
//

#import "REPSparkleScene.h"

@interface REPSparkleScene()

@property (nonatomic, nonnull) SKEmitterNode *sparkleNode;

@end


@implementation REPSparkleScene

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
	if ([super initWithCoder:aDecoder]) {
//		[self commonInit];
	}
	return self;
}

- (instancetype)initWithSize:(CGSize)size {
	if (self = [super initWithSize:size]) {
	}
	return self;
}

- (void)commonInit {
	NSBundle *bundle = [NSBundle bundleForClass:[REPSparkleScene class]];
	NSURL *sparkleURL = [bundle URLForResource:@"Sparkles" withExtension:@"sks"];
	_sparkleNode = [NSKeyedUnarchiver unarchiveObjectWithFile: sparkleURL.path];

	_progress = 0.0;
	_backgroundStrength = 0.8;
	_animationSpeed = 100.0;
	_yPosition = self.size.height / 2.0;
}

- (void)sceneDidLoad {
	[self commonInit];
	[self addChild:self.sparkleNode];
	self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:self.backgroundStrength];
}

- (void)updateAnimation {
	CGFloat insetValue = 20.0;
	CGFloat barWidth = self.frame.size.width - (insetValue * 2.0);
	CGFloat barWidthHalf = barWidth / 2.0;
	CGFloat barProgressWidth = barWidth * self.progress;
	CGFloat barProgressWidthHalf = barProgressWidth / 2.0;
	CGFloat barHeight = 40.0;
	CGFloat barHeightHalf = barHeight / 2.0;
	CGFloat yPositionMid = self.yPosition;

	CGPoint leftTop = CGPointMake(insetValue, yPositionMid + barHeightHalf);
	CGPoint leftMid = CGPointMake(insetValue, yPositionMid);
	CGPoint leftBottom = CGPointMake(insetValue, yPositionMid - barHeightHalf);
	CGPoint rightTop = CGPointMake(insetValue + barProgressWidth, yPositionMid + barHeightHalf);
	CGPoint rightMid = CGPointMake(insetValue + barProgressWidth, yPositionMid);
	CGPoint rightBottom = CGPointMake(insetValue + barProgressWidth, yPositionMid - barHeightHalf);
	CGPoint midTop = CGPointMake(insetValue + barProgressWidthHalf, yPositionMid + barHeightHalf);
	CGPoint midBottom = CGPointMake(insetValue + barProgressWidthHalf, yPositionMid - barHeightHalf);

	CGMutablePathRef path = CGPathCreateMutable();
	CGPathMoveToPoint(path, nil, leftMid.x, leftMid.y);
	CGPathAddQuadCurveToPoint(path, nil, leftTop.x, leftTop.y, midTop.x, midTop.y);
	CGPathAddQuadCurveToPoint(path, nil, rightTop.x, rightTop.y, rightMid.x, rightMid.y);
	CGPathAddQuadCurveToPoint(path, nil, rightBottom.x, rightBottom.y, midBottom.x, midBottom.y);
	CGPathAddQuadCurveToPoint(path, nil, leftBottom.x, leftBottom.y, leftMid.x, leftMid.y);
	CGPathCloseSubpath(path);

	SKAction *pathAnimation = [SKAction followPath:path asOffset:NO orientToPath:NO speed:self.animationSpeed];

	CGPathRelease(path);

	[self.sparkleNode runAction:pathAnimation withKey:@"pathAnimation"];
}

- (void)didChangeSize:(CGSize)oldSize {
	[super didChangeSize:oldSize];
	[self updateAnimation];
}

- (void)setProgress:(CGFloat)progress {
	_progress = progress;
	[self updateAnimation];
}

@end