//
//  GradientCell.m
//  PhotoColorGrad
//
//  Created by Michael Redig on 4/11/20.
//  Copyright © 2020 Red_Egg Productions. All rights reserved.
//

#import "GradientCell.h"
#import "GradientView.h"

@interface GradientCell()

@property (weak, nonatomic) IBOutlet GradientView *gradientView;


@end

@implementation GradientCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:false animated:false];
}

- (void)setGradientColors:(NSArray<UIColor *> *)gradientColors {
	self.gradientView.colors = gradientColors;
}

- (NSArray<UIColor *> *)gradientColors {
	return self.gradientView.colors;
}

@end
