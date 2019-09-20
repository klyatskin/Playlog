//
//  UIColor+ButtonState.h
//  Playlog
//
//  Created by Konstantin Klyatskin on 2019-09-18.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (ButtonState)

+ (UIColor *)releasedColor;
+ (UIColor *)pushedColor;
+ (UIColor *)randomColor;

@end

NS_ASSUME_NONNULL_END
