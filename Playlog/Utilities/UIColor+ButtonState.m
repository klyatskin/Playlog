//
//  UIColor+ButtonState.m
//  Playlog
//
//  Created by Konstantin Klyatskin on 2019-09-18.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

#import "UIColor+ButtonState.h"

@implementation UIColor (ButtonState)

+ (UIColor *)releasedColor {
    return [UIColor greenColor];
}

+ (UIColor *)pushedColor {
    return [UIColor blueColor];
}

+ (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

@end
