//
//  NSArray+Randomize.h
//  Playlog
//
//  Created by Konstantin Klyatskin on 2019-09-18.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (Randomize)

+ (nullable NSArray <NSNumber *> *)arrayOfRandomIndexesWithCapacity:(NSUInteger)capacity fromLength:(NSUInteger)length; 

@end

NS_ASSUME_NONNULL_END
