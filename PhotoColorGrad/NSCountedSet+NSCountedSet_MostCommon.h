//
//  NSCountedSet+NSCountedSet_MostCommon.h
//  PhotoColorGrad
//
//  Created by Michael Redig on 4/10/20.
//  Copyright © 2020 Red_Egg Productions. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSCountedSet (NSCountedSet_MostCommon)

@property (nonatomic, readonly) NSArray *allItemsInOrderOfCount;

@end

NS_ASSUME_NONNULL_END
