//
//  UIImage+Create.h
//  Playlog
//
//  Created by Konstantin Klyatskin on 2019-09-18.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Create)

+ (UIImage *)imageWithInteger:(int)num save:(Boolean)save;
+ (void)debugCreateAndSave3000Images;

@end

NS_ASSUME_NONNULL_END