//
//  ImageDetails.m
//  MPMovieController
//
//  Created by boney_p on 22/05/15.
//  Copyright (c) 2015 boney_p. All rights reserved.
//

#import "ImageDetails.h"

@implementation ImageDetails

-(instancetype)initWithImage:(UIImage*)thumbnailImage andPlayLocation:(CMTime)time{
    
    self.thumbnailImage = thumbnailImage;
    self.framePlayLocation = time;
    return self;
}

@end
