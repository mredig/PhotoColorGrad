//
//  REPSparkleViewController.m
//  SparkleProgress
//
//  Created by Michael Redig on 4/14/20.
//  Copyright © 2020 Red_Egg Productions. All rights reserved.
//

#import "REPSparkleViewController.h"
#import "REPSparkleView.h"

@interface REPSparkleViewController ()

@property (nonatomic, nonnull) REPSparkleView *sparkleView;

@end

@implementation REPSparkleViewController

- (instancetype)initWithCoder:(NSCoder *)coder {
	if (self = [super initWithCoder:coder]) {
		[self commonInit];
	}
	return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		[self commonInit];
	}
	return self;
}


- (void)commonInit {
	_sparkleView = [[REPSparkleView alloc] initWithFrame:self.view.bounds];

	self.view.backgroundColor = [UIColor clearColor];
	[self.view addSubview:self.sparkleView];
	self.sparkleView.translatesAutoresizingMaskIntoConstraints = NO;

	NSArray<NSLayoutConstraint *> *constraints = @[
		[self.sparkleView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
		[self.sparkleView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
		[self.sparkleView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
		[self.sparkleView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor]
	];
	for (NSLayoutConstraint *constraint in constraints) {
		constraint.active = YES;
	}
//NSLayoutConstraint *topConstraint = [self.sparkleView.topAnchor constraintEqualToAnchor:self.view.topAnchor];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// MARK: - Properties
- (void)setProgress:(CGFloat)progress {
	self.sparkleView.progress = progress;
}

- (CGFloat)progress {
	return self.sparkleView.progress;
}

- (void)setBackgroundStrength:(CGFloat)backgroundStrength {
	self.sparkleView.backgroundStrength = backgroundStrength;
}

- (CGFloat)backgroundStrength {
	return self.sparkleView.backgroundStrength;
}

- (void)setYPosition:(CGFloat)yPosition {
	self.sparkleView.yPosition = yPosition;
}

- (CGFloat)yPosition {
	return self.sparkleView.yPosition;
}

- (void)setAnimationSpeed:(CGFloat)animationSpeed {
	self.sparkleView.animationSpeed = animationSpeed;
}

- (CGFloat)animationSpeed {
	return self.sparkleView.animationSpeed;
}


@end
