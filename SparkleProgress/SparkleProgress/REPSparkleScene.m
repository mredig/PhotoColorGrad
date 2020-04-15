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

//	NSData *emitterData = [NSData dataWithContentsOfURL:sparkleURL];
//	NSError *loadError;
//	_sparkleNode = [NSKeyedUnarchiver unarchivedObjectOfClass:[SKEmitterNode class] fromData:emitterData error:&loadError];
//	if (loadError != nil) {
//		NSLog(@"Error loading sparkles: %@", loadError);
//	}
	_sparkleNode = [NSKeyedUnarchiver unarchiveObjectWithFile: sparkleURL.path];
	self.sparkleNode.particleTexture = [SKTexture textureWithImage:sparkImage];
	self.sparkleNode.targetNode = self;

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
//	CGFloat barProgressWidthHalf = barProgressWidth / 2.0;
//	CGFloat barHeight = 10.0;
//	CGFloat barHeightHalf = barHeight / 2.0;
	CGFloat yPositionMid = self.yPosition;
//
//	CGPoint leftTop = CGPointMake(insetValue, yPositionMid + barHeightHalf);
//	CGPoint leftMid = CGPointMake(insetValue, yPositionMid);
//	CGPoint leftBottom = CGPointMake(insetValue, yPositionMid - barHeightHalf);
//	CGPoint rightTop = CGPointMake(insetValue + barProgressWidth, yPositionMid + barHeightHalf);
//	CGPoint rightMid = CGPointMake(insetValue + barProgressWidth, yPositionMid);
//	CGPoint rightBottom = CGPointMake(insetValue + barProgressWidth, yPositionMid - barHeightHalf);
//	CGPoint midTop = CGPointMake(insetValue + barProgressWidthHalf, yPositionMid + barHeightHalf);
//	CGPoint midBottom = CGPointMake(insetValue + barProgressWidthHalf, yPositionMid - barHeightHalf);
//
//	CGMutablePathRef path = CGPathCreateMutable();
//	CGPathMoveToPoint(path, nil, leftMid.x, leftMid.y);
//	CGPathAddQuadCurveToPoint(path, nil, leftTop.x, leftTop.y, midTop.x, midTop.y);
//	CGPathAddQuadCurveToPoint(path, nil, rightTop.x, rightTop.y, rightMid.x, rightMid.y);
//	CGPathAddQuadCurveToPoint(path, nil, rightBottom.x, rightBottom.y, midBottom.x, midBottom.y);
//	CGPathAddQuadCurveToPoint(path, nil, leftBottom.x, leftBottom.y, leftMid.x, leftMid.y);
//	CGPathCloseSubpath(path);
//
//	SKAction *pathAnimation = [SKAction followPath:path asOffset:NO orientToPath:NO speed:self.animationSpeed];
//	SKAction *repeat = [SKAction repeatActionForever:pathAnimation];
//
//	CGPathRelease(path);
//
//	[self.sparkleNode runAction:repeat withKey:@"pathAnimation"];

	uint32_t random = arc4random_uniform(1000000);
	CGFloat randomDouble = (CGFloat)random / 1000000.0;
	randomDouble *= barProgressWidth;
	randomDouble += insetValue;
	self.sparkleNode.position = CGPointMake(randomDouble, yPositionMid);
}

- (void)didChangeSize:(CGSize)oldSize {
	[super didChangeSize:oldSize];
}

- (void)update:(NSTimeInterval)currentTime {
	double thing = 1.0;

//	NSLog(@"%f", modf(currentTime, &thing));
//	printf("%f\n", modf(currentTime, &thing));
	[self updateAnimation];
}

- (void)setProgress:(CGFloat)progress {
	_progress = progress;
	[self updateAnimation];
}

@end
