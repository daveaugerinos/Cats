//
//  PhotoCollectionViewCell.m
//  Cats
//
//  Created by Dave Augerinos on 2017-02-27.
//  Copyright © 2017 Dave Augerinos. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@interface PhotoCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *photoTitleLabel;

@end

@implementation PhotoCollectionViewCell

-(void)setMyPhoto:(Photo *)photo {
    
    _myPhoto = photo;
    [self configureCellWithPhoto];
}

-(void)configureCellWithPhoto {
    
    self.photoImageView.image = nil;
    self.photoTitleLabel.text = @"Downloading...";
    
    NSURL *url = self.myPhoto.url;
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(error) {
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSData *data = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:data];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
            self.myPhoto.myImage = image;
            self.photoImageView.image = self.myPhoto.myImage;
            self.photoTitleLabel.text = self.myPhoto.title;
        }];
    }];
    
    [downloadTask resume];
}

@end
