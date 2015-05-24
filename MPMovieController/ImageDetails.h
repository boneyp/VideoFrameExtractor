//
//  ImageDetails.h
//  MPMovieController
//
//  Created by boney_p on 22/05/15.
//  Copyright (c) 2015 boney_p. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ImageDetails : NSObject
{}

@property (nonatomic) UIImage* thumbnailImage;
@property (nonatomic,assign) CMTime framePlayLocation;

-(instancetype)initWithImage:(UIImage*)thumbnailImage andPlayLocation:(CMTime)time;
@end
