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

	UIImage *sparkImage = [UIImage imageNamed:@"spark" inBundle:bundle withConfiguration:nil];

	// FIXME: does the new, non deprecated function
//	NSData *emitterData = [NSData dataWithContentsOfURL:sparkleURL];
//	NSError *loadError;
//	_sparkleNode = [NSKeyedUnarchiver unarchivedObjectOfClass:[SKEmitterNode class] fromData:emitterData error:&loadError];
//	if (loadError != nil) {
//		NSLog(@"Error loading sparkles: %@", loadError);
//	}
	_sparkleNode = [NSKeyedUnarchiver unarchiveObjectWithFile: sparkleURL.path];
	_sparkleNode.particleTexture = [SKTexture textureWithImage:sparkImage];
	_sparkleNode.targetNode = self;

	_progress = 1.0;
	_backgroundStrength = 0.8;
	_animationSpeed = 10000.0;
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
//	CGFloat barWidthHalf = barWidth / 2.0;
	CGFloat barProgressWidth = barWidth * self.progress;
	CGFloat barProgressWidthHalf = barProgressWidth / 2.0;
//	CGFloat barHeight = 10.0;
//	CGFloat barHeightHalf = barHeight / 2.0;
	CGFloat yPositionMid = self.yPosition;

	self.sparkleNode.position = CGPointMake(barProgressWidthHalf + insetValue, yPositionMid);
	self.sparkleNode.particlePositionRange = CGVectorMake(barProgressWidth, 0);
	self.sparkleNode.particleBirthRate = 35 * barProgressWidth;
}

- (void)setProgress:(CGFloat)progress {
	_progress = progress;
	[self updateAnimation];
}

@end
