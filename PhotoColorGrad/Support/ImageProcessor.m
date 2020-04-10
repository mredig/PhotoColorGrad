//
//  REPImageProcessor.m
//  PhotoColorGrad
//
//  Created by Michael Redig on 4/10/20.
//  Copyright © 2020 Red_Egg Productions. All rights reserved.
//

#import "REPImageProcessor.h"
#import <UIKit/UIKit.h>


@implementation REPImageProcessor

//- (instancetype)init;
//
//- (void)loadImage:(UIImage *)image;

- (instancetype)init {
	if (self = [super init]) {

	}
	return self;
}

- (void)loadImage:(UIImage *)image completionHandler:(REPImageProcessorCompletionHandler)completion {


	completion();
}

@end
