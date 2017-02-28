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
    
    self.photoImageView.image = self.myPhoto.myImage;
    self.photoTitleLabel.text = self.myPhoto.title;
    
    
}

@end
