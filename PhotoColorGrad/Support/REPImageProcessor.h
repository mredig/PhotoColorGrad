//
//  REPImageProcessor.h
//  PhotoColorGrad
//
//  Created by Michael Redig on 4/10/20.
//  Copyright © 2020 Red_Egg Productions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

@interface REPImageProcessor : NSObject

typedef void (^REPImageProcessorCompletionHandler)(void);

- (instancetype)init;

- (void)loadImage:(UIImage *)image completionHandler:(REPImageProcessorCompletionHandler)completion;


@end

NS_ASSUME_NONNULL_END
