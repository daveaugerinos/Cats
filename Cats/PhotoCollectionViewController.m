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

@interface PhotoCollectionViewController ()

@property (strong, nonatomic) IBOutlet UICollectionView *photoCollectionView;
@property (nonatomic, strong) NSArray *photos;

@end

@implementation PhotoCollectionViewController

static NSString *const reuseIdentifier = @"photoCell";
static NSString *const photoDetailVCSegueIdentifier = @"photoDetailVC";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.photos = [self prepareDataSource];
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
        Photo *photo = [self.photos objectAtIndex:indexPath.item];
        PhotoDetailViewController *detailVC = segue.destinationViewController;
        detailVC.myPhoto = photo;
    }
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return [self.photos count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    Photo *photo = [self.photos objectAtIndex:indexPath.item];
    cell.myPhoto = photo;
    
    return cell;
}


#pragma mark - Helper -

- (NSArray *)prepareDataSource {
    
    Photo *photo1 = [[Photo alloc] initWithImage:[UIImage imageNamed:@"cat-0" ] andTitle:@"cat 0" ];
    
    Photo *photo2 = [[Photo alloc] initWithImage:[UIImage imageNamed:@"cat-1" ] andTitle:@"cat 1" ];
    
    Photo *photo3 = [[Photo alloc] initWithImage:[UIImage imageNamed:@"cat-2" ] andTitle:@"cat 2" ];
    
    NSArray *initialArray = @[photo1, photo2, photo3];
    
    return initialArray;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
