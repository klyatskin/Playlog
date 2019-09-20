//
//  NSArray+Randomize.m
//  Playlog
//
//  Created by Konstantin Klyatskin on 2019-09-18.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

#import "NSArray+Randomize.h"

@implementation NSArray (Randomize)

+ (nullable NSArray <NSNumber *> *)arrayOfRandomIndexesWithCapacity:(NSUInteger)capacity fromLength:(NSUInteger)length  {
    static NSMutableArray * indexes;
    if (capacity == 0)
        return NULL;
    if (capacity > length)
        return NULL;
    if (indexes.count != length) { // new array
        indexes = [NSMutableArray arrayWithCapacity:length];
        for (NSUInteger i=0; i< length; i++)
            indexes[i] = [NSNumber numberWithInteger:i];
    }
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:capacity];
    for (int i=0; i<capacity; i++) {
        int k = arc4random_uniform((uint32_t)(length-i));
        result[i] = indexes[k];
        [indexes exchangeObjectAtIndex:k withObjectAtIndex:length-1-i];
    }
    return result;
}


- (NSArray *)shuffled { // Fisher–Yates shuffle
    NSMutableArray *shuffled = [self mutableCopy];
    for (NSUInteger i = self.count - 1; i > 0; i--) {
        NSUInteger j = arc4random_uniform((uint32_t)i + 1);
        [shuffled exchangeObjectAtIndex:i withObjectAtIndex:j];
    }
    return shuffled;
}

@end
