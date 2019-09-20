//
//  ViewController.m
//  Playlog
//
//  Created by Konstantin Klyatskin on 2019-09-17.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Create.h"
#import "UIViewController+Alert.h"
#import "NSArray+Randomize.h"

@import Photos;

@interface ViewController () <ButtonViewTapProtocol> {
    int _x;
    CGFloat _buttonAngle;
}

@property (strong) PHFetchResult *assetsFetchResults;
@property (strong) NSArray <NSNumber *> *randomIndexes;

@end

@implementation ViewController


- (void)viewDidLayoutSubviews {
    // do it once on adjusted screen
    [super viewDidLayoutSubviews];
    if (self.viewButton.delegate != self) {
        [super viewDidLayoutSubviews];
        [self.viewWheel setupView];
        [self.viewButton setupView];
        self.viewButton.delegate = self;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self tryAccessToPhotos];
}

-(BOOL)shouldAutorotate {
    return NO;
}

#pragma mark - Photos

- (void)tryAccessToPhotos {
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    __weak typeof(self) weakSelf = self;
    void (^ statusHandler)(PHAuthorizationStatus) = ^(PHAuthorizationStatus status) {
        NSLog(@"Status = %ld", (long)status);
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf tryAccessToPhotos]; // try again
        });
    };
    switch (status) {
        case PHAuthorizationStatusNotDetermined:
            [PHPhotoLibrary requestAuthorization:statusHandler];
            break;
        case PHAuthorizationStatusAuthorized:
            [self setupAssets];
            break;
        default:
            [self showAlertWithMessage: @"You should allow access to photos in app's preferences."];
    }
}

- (void)setupAssets {
    PHFetchOptions *allPhotosOptions = [PHFetchOptions new];
    allPhotosOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    self.assetsFetchResults = [PHAsset fetchAssetsWithOptions:allPhotosOptions];
    NSLog(@"Found %@", self.assetsFetchResults);
    if (self.assetsFetchResults.count < 20)
        [self showAlertWithMessage:@"The app needs at least 20 photos to be presented on device. Make additional photos and RELAUNCH the app."];
    [self randomizeX];
}

- (void)updateWithRandomImages {
    // refresh array of random indexes
    [self randomizeImages];
    // clear stack
    [self.stackView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    // refresh stack
    void (^ imageDataRequestResultHandler)(NSData *, NSString *, UIImageOrientation, NSDictionary *) =
        ^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImage *im = [UIImage imageWithData:imageData];
                [self.stackView addArrangedSubview:[[UIImageView alloc] initWithImage:im]];
                if (self.stackView.subviews.count == self.randomIndexes.count) // all images are in stack
                    [self updateBackground];
            });
        };
    // get image
    PHAsset *asset;
    for (NSNumber *num in self.randomIndexes) {
        asset = self.assetsFetchResults[num.integerValue ];
        PHImageRequestOptions *imageRequestOptions = [PHImageRequestOptions new];
        [[PHImageManager defaultManager] requestImageDataForAsset:asset options:imageRequestOptions resultHandler:imageDataRequestResultHandler];
    }
}

- (void)updateBackground {
    // based upon angle, X and stack...
    if (_buttonAngle <0)
        _buttonAngle += 2. * M_PI;
    int num = (self.stackView.subviews.count) * _buttonAngle / (2.* M_PI);
    self.viewImage.image = [self.stackView.subviews[num] image];
}

- (void)randomizeImages {
    self.randomIndexes = [NSArray arrayOfRandomIndexesWithCapacity:_x fromLength:self.assetsFetchResults.count];
}


-(void)randomizeX {
    int x;
    do {
        x = arc4random_uniform((uint32_t)self.segmentedX.numberOfSegments);
    } while (x == _x);
    self.segmentedX.selectedSegmentIndex = x;
    [self segmentedValueChanged:self.segmentedX];
}

#pragma mark - Actions

- (IBAction)segmentedValueChanged:(UISegmentedControl *)sender {
    _x = (int)sender.selectedSegmentIndex + 10;
    self.labelX.text = [NSString stringWithFormat:@"X= %02d", _x];
    [self updateWithRandomImages];
}

#pragma mark - Button delegate

- (void)buttonTappedAndMoved:(ButtonView *)button {
    _buttonAngle = button.angle;
    [self randomizeX];
}

- (void)buttonMoved:(ButtonView *)button {
    _buttonAngle = button.angle;
    [self updateBackground];
}


@end
