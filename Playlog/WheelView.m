//
//  WheelView.m
//  Playlog
//
//  Created by Konstantin Klyatskin on 2019-09-17.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

#import "WheelView.h"

@implementation WheelView

- (void)setupView {
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    self.layer.cornerRadius = self.frame.size.height/2.;
    self.layer.borderColor = [UIColor redColor].CGColor;
    self.layer.borderWidth = 4.0;
    self.clipsToBounds = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
