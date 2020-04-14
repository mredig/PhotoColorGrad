//
//  REPSparkleScene.h
//  SparkleProgress
//
//  Created by Michael Redig on 4/14/20.
//  Copyright © 2020 Red_Egg Productions. All rights reserved.
//

@import SpriteKit;

NS_ASSUME_NONNULL_BEGIN

@interface REPSparkleScene : SKScene

@property (nonatomic) CGFloat progress;
@property (nonatomic) CGFloat backgroundStrength;
@property (nonatomic) CGFloat yPosition;
@property (nonatomic) CGFloat animationSpeed;

- (instancetype)initWithCoder:(NSCoder *)aDecoder;
- (instancetype)initWithSize:(CGSize)size;


@end

NS_ASSUME_NONNULL_END
