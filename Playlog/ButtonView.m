//
//  ButtonView.m
//  Playlog
//
//  Created by Konstantin Klyatskin on 2019-09-17.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

#import "ButtonView.h"
#import "UIColor+ButtonState.h"


@interface ButtonView() <CAAnimationDelegate> {
    CGPoint _lastLocation;
    CGFloat _radius;
    CGPoint _center;
    UILabel *_labelAngle;
}

@end

@implementation ButtonView

- (void)setupView {
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(detectPan:)];
    panRecognizer.maximumNumberOfTouches = 1;
    self.gestureRecognizers = @[panRecognizer];
    // calcs for geometry
    _center = CGPointMake(self.superview.frame.size.width/2., self.superview.frame.size.height/2.);
    _radius = _center.y - self.center.y;
    // visualize
    self.layer.cornerRadius = self.frame.size.height/2.;
    self.layer.borderColor = [UIColor redColor].CGColor;
    self.layer.borderWidth = 2.0;
    _labelAngle = self.subviews[0];
    self.backgroundColor = [UIColor releasedColor];
}

- (void)detectPan:(UIPanGestureRecognizer *)recognizer {
    CGPoint translation = [recognizer translationInView:self.superview];
    CGPoint destination = CGPointMake(_lastLocation.x + translation.x,_lastLocation.y + translation.y);
    self.center = destination;
    self.angle = atan((- destination.x + _center.x)/(destination.y - _center.y));
    if (destination.y >_center.y)
        self.angle += M_PI;
    self.center = [self pointForAngle:self.angle];
    [self.delegate buttonMoved:self];
}


#pragma mark -Touch recognition

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _lastLocation = self.center;
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.backgroundColor = [UIColor releasedColor];
//  button tapped
    [self animateToRandomPosition];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.backgroundColor = [UIColor pushedColor];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.backgroundColor = [UIColor releasedColor];
  
}


#pragma mark - geometry calcs

- (CGPoint)pointForAngle:(CGFloat)angle {
    return CGPointMake(_center.x + _radius * sin(angle), _center.y - _radius * cos(angle));
}


- (void)setAngle:(CGFloat)angle {
    _angle = angle;
    int intAngle =  angle * 180.0 /M_PI + 360;
    intAngle = intAngle % 360;
    NSString *text = [NSString stringWithFormat:@"%03d", intAngle];
    _labelAngle.text = text;
}

#pragma mark - Animation

- (void)animateToRandomPosition {
    int randomAngle = arc4random_uniform(360);
    CGFloat endAngle = randomAngle * M_PI / 180.;
    NSLog(@"Tapped. %d", randomAngle);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:_center radius:_radius startAngle:_angle-M_PI/2. endAngle:endAngle-M_PI/2. clockwise:YES];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.delegate = self;
    animation.keyPath = @"position";
    animation.duration = .5 + arc4random_uniform(2);
    animation.path = path.CGPath;
    
    [self.layer addAnimation:animation forKey:@"button move"];
    self.center = [self pointForAngle:endAngle];
    self.angle = endAngle;
}

- (void)animationDidStart:(CAAnimation *)anim {
    _labelAngle.hidden = YES;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    _labelAngle.hidden = NO;
    [self.delegate buttonTappedAndMoved:self];
}


@end
