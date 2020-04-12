//
//  GradientCell.m
//  PhotoColorGrad
//
//  Created by Michael Redig on 4/11/20.
//  Copyright © 2020 Red_Egg Productions. All rights reserved.
//

#import "GradientCell.h"
#import "GradientView.h"
#import "PhotoColorGrad-Swift.h"

@interface GradientCell()

@property (weak, nonatomic) IBOutlet GradientView *gradientView;
@property (weak, nonatomic) IBOutlet UIView *backingView;
@property (weak, nonatomic) IBOutlet UILabel *hexLabel;


@end

@implementation GradientCell

- (void)awakeFromNib {
	[super awakeFromNib];
	self.backingView.layer.cornerRadius = 10;
	self.backingView.hidden = true;
}

- (void)updateViews {
	if (self.gradientColors == nil) {
		return;
	}

	NSMutableArray *hexStrings = [NSMutableArray arrayWithCapacity:self.gradientColors.count];

	for (UIColor* color in self.gradientColors) {
		NSString *hexString = [NSString stringWithFormat:@"0x%@", color.hexString];
		[hexStrings addObject:hexString];
	}

	NSString* final = [hexStrings componentsJoinedByString:@" | "];
	self.hexLabel.text = final;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
	self.backingView.hidden = !selected;
}

- (void)prepareForReuse {
	[super prepareForReuse];
	self.backingView.hidden = YES;
}

- (void)setGradientColors:(NSArray<UIColor *> *)gradientColors {
	self.gradientView.colors = gradientColors;
	[self updateViews];
}

- (NSArray<UIColor *> *)gradientColors {
	return self.gradientView.colors;
}

@end
