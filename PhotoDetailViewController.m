//
//  PhotoDetailViewController.m
//  Cats
//
//  Created by Dave Augerinos on 2017-02-27.
//  Copyright © 2017 Dave Augerinos. All rights reserved.
//

#import "PhotoDetailViewController.h"

@interface PhotoDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *photoDetailImageView;
@property (weak, nonatomic) IBOutlet UILabel *photoDetailTitleLabel;

@end

@implementation PhotoDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureWithPhoto];
}

- (void)configureWithPhoto {
    
    self.photoDetailImageView.image = self.myPhoto.myImage;
    self.photoDetailTitleLabel.text = self.myPhoto.title;
}

@end
