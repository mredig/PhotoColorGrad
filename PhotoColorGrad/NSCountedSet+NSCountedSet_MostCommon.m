//
//  NSCountedSet+NSCountedSet_MostCommon.m
//  PhotoColorGrad
//
//  Created by Michael Redig on 4/10/20.
//  Copyright © 2020 Red_Egg Productions. All rights reserved.
//

#import "NSCountedSet+NSCountedSet_MostCommon.h"
#import "REPImagePixel.h"


/// this ended up not being used, but keeping around since its a good example
@implementation NSCountedSet (NSCountedSet_MostCommon)

- (NSArray *)allItemsInOrderOfCount {
	return [self calculateRankingOfItemOccurrance];
}

- (NSArray *)calculateRankingOfItemOccurrance {
	NSMutableArray *orderedItems = [NSMutableArray array];

	[self enumerateObjectsUsingBlock:^(REPImagePixel*  _Nonnull obj, BOOL * _Nonnull stop) {
		NSNumber *count = [NSNumber numberWithUnsignedInteger: [self countForObject:obj]];
		[orderedItems addObject:@[obj, count]];
	}];

	[orderedItems sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
		NSNumber *aCount = (NSNumber*)(NSArray*)obj1[1];
		NSNumber *bCount = (NSNumber*)(NSArray*)obj2[1];

		return [aCount compare:bCount] == NSOrderedAscending;
	}];

	return [orderedItems copy];
}

@end
