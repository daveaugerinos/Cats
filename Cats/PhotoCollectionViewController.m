//
//  PhotoCollectionViewController.m
//  Cats
//
//  Created by Dave Augerinos on 2017-02-27.
//  Copyright © 2017 Dave Augerinos. All rights reserved.
//

#import "PhotoCollectionViewController.h"
#import "Photo.h"
#import "PhotoCollectionViewCell.h"
#import "PhotoDetailViewController.h"
#import "NetworkManager.h"

@interface PhotoCollectionViewController ()

@property (strong, nonatomic) IBOutlet UICollectionView *photoCollectionView;
@property (nonatomic, strong) NSMutableArray *photosArray;

@end

@implementation PhotoCollectionViewController

static NSString *const reuseIdentifier = @"photoCell";
static NSString *const photoDetailVCSegueIdentifier = @"photoDetailVC";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.photosArray = [[NSMutableArray alloc]init];
    
    NetworkManager *networkManager = [[NetworkManager alloc] init];
    
    [networkManager getPhotos:^(NSMutableArray *photosArray, NSError * _Nullable error) {
        
        self.photosArray = photosArray;
        [self.photoCollectionView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath = [self.photoCollectionView indexPathForCell:sender];
    
    if ([segue.identifier isEqualToString:photoDetailVCSegueIdentifier])
    {
        Photo *photo = [self.photosArray objectAtIndex:indexPath.item];
        PhotoDetailViewController *detailVC = segue.destinationViewController;
        detailVC.myPhoto = photo;
    }
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [self.photosArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    Photo *photo = [self.photosArray objectAtIndex:indexPath.item];
    cell.myPhoto = photo;
    
    return cell;
}

@end
