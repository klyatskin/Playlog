//
//  ViewController.h
//  Playlog
//
//  Created by Konstantin Klyatskin on 2019-09-17.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WheelView.h"
#import "ButtonView.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet WheelView *viewWheel;
@property (weak, nonatomic) IBOutlet UIImageView *viewImage;
@property (weak, nonatomic) IBOutlet ButtonView *viewButton;
@property (weak, nonatomic) IBOutlet UILabel *labelX;
@property (weak, nonatomic) IBOutlet UIStackView *stackView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedX;


@end

