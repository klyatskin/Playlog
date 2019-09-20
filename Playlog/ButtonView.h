//
//  ButtonView.h
//  Playlog
//
//  Created by Konstantin Klyatskin on 2019-09-17.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ButtonView;


@protocol ButtonViewTapProtocol <NSObject>

- (void)buttonTappedAndMoved:(ButtonView *)button;
- (void)buttonMoved:(ButtonView *)button;

@end


@interface ButtonView : UIView

@property (nonatomic) CGFloat angle;
@property (nonatomic,weak) id <ButtonViewTapProtocol> delegate;

- (void)setupView;

@end




NS_ASSUME_NONNULL_END
