//
//  REPImageProcessor.h
//  PhotoColorGrad
//
//  Created by Michael Redig on 4/10/20.
//  Copyright © 2020 Red_Egg Productions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface REPImageProcessor : NSObject

@property (nonatomic, readonly) NSArray<UIColor *> *colors;

typedef void (^REPImageProcessorCompletionHandler)(void);

- (instancetype)init;

- (void)loadImage:(UIImage *)image completionHandler:(REPImageProcessorCompletionHandler)completion;


@end

NS_ASSUME_NONNULL_END
