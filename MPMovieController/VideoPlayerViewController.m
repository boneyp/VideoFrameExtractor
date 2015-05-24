//
//  ViewController.m
//  MPMovieController
//
//  Created by boney_p on 20/05/15.
//  Copyright (c) 2015 boney_p. All rights reserved.
//

#import "VideoPlayerViewController.h"
#import "ThumbnailImageCell.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "ImageDetails.h"

#define  framesExtractionInterval 10
@interface VideoPlayerViewController () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) MPMoviePlayerController* moviePlayer;
@property (nonatomic,strong) NSMutableArray *ImagesMainArray;
@property (nonatomic,strong) NSURL* bundleMoviePath;

@property (nonatomic,strong) NSArray* imagesArray;

@end

@implementation VideoPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[ThumbnailImageCell class] forCellWithReuseIdentifier:@"Cell"];
    //get movie path from bundle
    self.ImagesMainArray = [[NSMutableArray alloc]init];
    self.bundleMoviePath =[[NSBundle mainBundle]URLForResource:@"Behroopia - [HQ] [Webmusic.IN]" withExtension:@".mp4"];
    
    //self.bundleMoviePath =[[NSBundle mainBundle]URLForResource:@"movie" withExtension:@".mov"];
    [self ProcessThumbnailImage];
    //Create MPMoviewPlayerController
    [self createMoviePlayer];
    //AddMPMoviewPlayer to the interface
    [self.moviePlayer.view setAutoresizesSubviews:NO];

    [self.bgViewForMPView addSubview:self.moviePlayer.view];

    
}

-(void)createMoviePlayer{
    self.moviePlayer = [[MPMoviePlayerController alloc]initWithContentURL:self.bundleMoviePath];
    [self.moviePlayer prepareToPlay];
    self.moviePlayer.view.frame = CGRectMake(16, 0, 300, 220);
    self.moviePlayer.shouldAutoplay =NO;
    self.moviePlayer.controlStyle = MPMovieControlStyleNone;
    self.moviePlayer.backgroundView.backgroundColor = [UIColor whiteColor];
}

// movie play button action
-(IBAction)play:(id)sender{
    [self.moviePlayer play];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ProcessThumbnailImage) name:MPMoviePlayerThumbnailImageRequestDidFinishNotification object:self.moviePlayer];
}

// movie stop  play button action
-(IBAction)stop:(id)sender{
     [self.moviePlayer pause];
}

-(void)ProcessThumbnailImage{
    
    AVURLAsset *asset1 = [[AVURLAsset alloc] initWithURL:self.bundleMoviePath options:nil];
    AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset1];
    generator.appliesPreferredTrackTransform = YES;
    //Set the time and size of thumbnail for image
    NSError *err = NULL;
    for (int i=1; i<=(CMTimeGetSeconds(generator.asset.duration)/framesExtractionInterval);i++)
    {
        CMTime thumbTime = CMTimeMakeWithSeconds(i * framesExtractionInterval,3);
        CGSize maxSize = CGSizeMake(425,355);
        generator.maximumSize = maxSize;
        CGImageRef imgRef = [generator copyCGImageAtTime:thumbTime actualTime:NULL error:&err];
        UIImage *thumbnail = [[UIImage alloc] initWithCGImage:imgRef];
        ImageDetails* imageDetails = [[ImageDetails alloc]initWithImage:thumbnail andPlayLocation:thumbTime];
        [self.ImagesMainArray addObject:imageDetails];
    }
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDatasource
-(NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.ImagesMainArray.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    ThumbnailImageCell *cell = (ThumbnailImageCell*)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    ImageDetails* imageDetails =   [self.ImagesMainArray objectAtIndex:indexPath.row];
    UIImage* image = imageDetails.thumbnailImage;
    [cell.thumbnailImageView setImage:image];
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageDetails* imageDetails =   [self.ImagesMainArray objectAtIndex:indexPath.row];
    self.moviePlayer.currentPlaybackTime = CMTimeGetSeconds (imageDetails.framePlayLocation);
    [self.moviePlayer play];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
