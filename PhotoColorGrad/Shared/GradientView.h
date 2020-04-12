//
//  GradientView.h
//  PhotoColorGrad
//
//  Created by Michael Redig on 4/11/20.
//  Copyright © 2020 Red_Egg Productions. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GradientView : UIView

@property (nonatomic, readwrite) NSArray<UIColor *> *colors;

@end

NS_ASSUME_NONNULL_END
