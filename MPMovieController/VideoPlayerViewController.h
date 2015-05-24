//
//  ViewController.h
//  MPMovieController
//
//  Created by boney_p on 20/05/15.
//  Copyright (c) 2015 boney_p. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoPlayerViewController : UIViewController{
    
}
@property (nonatomic,weak) IBOutlet UICollectionView* collectionView;
@property (nonatomic,weak) IBOutlet UIView* bgViewForMPView;

-(IBAction)play:(id)sender;
-(IBAction)stop:(id)sender;

@end

