//
//  UIImage+Create.m
//  Playlog
//
//  Created by Konstantin Klyatskin on 2019-09-18.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

#import "UIImage+Create.h"
#import "UIColor+ButtonState.h"

@implementation UIImage (Create)


+ (void)debugCreateAndSave3000Images {
    for (int i=1; i<= 3000; i++)
        [UIImage imageWithInteger:i save:YES];
}

+ (UIImage *)imageWithInteger:(int)num save:(Boolean)save {
    
    @autoreleasepool {
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1536, 2048)];
        v.backgroundColor = [UIColor randomColor];
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(300,1000,1536 - 2 *300,100)];
        l.backgroundColor = [UIColor whiteColor];
        l.textColor = [UIColor blackColor];
        l.font = [UIFont systemFontOfSize:80];
        NSString *numString = [NSString stringWithFormat:@"%05d", num];
        l.text = numString;
        l.textAlignment = NSTextAlignmentCenter;
        [v addSubview:l];
        
        UIGraphicsBeginImageContextWithOptions(v.bounds.size, YES, 0.0f);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [v.layer renderInContext:context];
        UIImage *im = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        if (save) {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[numString stringByAppendingString:@".jpg"]];
            
            // Save image.
            [UIImageJPEGRepresentation(im, 0.5) writeToFile:filePath atomically:YES];    
        }
        return im;
    }
}


@end
