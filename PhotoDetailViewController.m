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
@property (weak, nonatomic) IBOutlet MKMapView *photMapView;


@end

@implementation PhotoDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureWithPhoto];
}

- (void)configureWithPhoto {
    
    self.photoDetailImageView.image = self.myPhoto.myImage;
    self.navigationItem.title = self.myPhoto.title;
    
    MKCoordinateSpan span = MKCoordinateSpanMake(.5f, .5f);
    self.photMapView.region =MKCoordinateRegionMake(self.myPhoto.coordinate, span);
    [self.photMapView addAnnotation:self.myPhoto];
}
@end
