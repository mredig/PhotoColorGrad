//
//  REPPixelCounter.m
//  PhotoColorGrad
//
//  Created by Michael Redig on 4/11/20.
//  Copyright © 2020 Red_Egg Productions. All rights reserved.
//

#import "REPPixelCounter.h"
#import "REPImagePixel.h"

@interface REPPixelCounter()

@property (nonatomic, readonly) NSMutableDictionary<REPImagePixel *, NSNumber *> *internalPixelCounts;

@end

@implementation REPPixelCounter

- (instancetype)init {
	if (self = [super init]) {
		_internalPixelCounts = [NSMutableDictionary dictionary];
	}
	return self;
}

- (void)addPixelToPixels:(REPImagePixel *)pixel {
	[self addPixelToPixels:pixel times:[NSNumber numberWithUnsignedInteger:1]];
}

- (void)addPixelToPixels:(REPImagePixel *)pixel times:(NSNumber *)count {
	NSNumber *previousCount = self.internalPixelCounts[pixel];
	if (previousCount == nil) {
		previousCount = [NSNumber numberWithUnsignedInteger:0];
	}
	self.internalPixelCounts[pixel] = [NSNumber numberWithUnsignedInteger:previousCount.unsignedIntegerValue + count.unsignedIntegerValue];
}

- (NSUInteger)removePixelFromPixels:(REPImagePixel *)pixel times:(NSNumber *)count {
	NSNumber *previousCount = self.internalPixelCounts[pixel];
	if (previousCount == nil) {
		previousCount = [NSNumber numberWithUnsignedInteger:0];
	}
	if (previousCount.unsignedIntegerValue < count.unsignedIntegerValue) {
		NSLog(@"removed more than there are");
		[self.internalPixelCounts removeObjectForKey:pixel];
		return previousCount.unsignedIntegerValue;
	}
	NSNumber *newValue = [NSNumber numberWithUnsignedInteger:previousCount.unsignedIntegerValue - count.unsignedIntegerValue];

	self.internalPixelCounts[pixel] = newValue;
	if (newValue.unsignedIntegerValue == 0) {
		[self.internalPixelCounts removeObjectForKey:pixel];
	}

	return count.unsignedIntegerValue;
}

- (NSUInteger)removePixelFromPixels:(REPImagePixel *)pixel {
	return [self removePixelFromPixels:pixel times:[NSNumber numberWithUnsignedInteger:1]];
}

- (NSUInteger)countForPixel:(REPImagePixel *)pixel {
	NSNumber *previousCount = self.internalPixelCounts[pixel];
	if (previousCount == nil) {
		previousCount = [NSNumber numberWithUnsignedInteger:0];
	}
	return previousCount.unsignedIntegerValue;
}

- (NSArray *)pixelsInOrder {
	return [self calculateRankingOfItemOccurrance];
}

- (NSArray *)calculateRankingOfItemOccurrance {
	NSMutableArray *orderedItems = [NSMutableArray array];

	[self.pixelCounts enumerateKeysAndObjectsUsingBlock:^(REPImagePixel * _Nonnull pixel, NSNumber * _Nonnull count, BOOL * _Nonnull stop) {
		[orderedItems addObject:@[pixel, count]];
	}];

	[orderedItems sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
		NSNumber *aCount = (NSNumber*)(NSArray*)obj1[1];
		NSNumber *bCount = (NSNumber*)(NSArray*)obj2[1];

		return [aCount compare:bCount] == NSOrderedAscending;
	}];

	return [orderedItems copy];
}


// MARK: - Properties

- (NSDictionary<REPImagePixel *,NSNumber *> *)pixelCounts {
	return [self.internalPixelCounts copy];
}

- (NSArray<REPImagePixel *> *)pixels {
	return [self.internalPixelCounts allKeys];
}

@end
