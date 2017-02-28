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
@property (nonatomic, strong) NSMutableArray *cats;

@end

@implementation PhotoCollectionViewController

static NSString *const reuseIdentifier = @"photoCell";
static NSString *const photoDetailVCSegueIdentifier = @"photoDetailVC";

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.photos = [self prepareDataSource];
    
    self.cats = [[NSMutableArray alloc]init];
    
    NSURL *url = [NSURL URLWithString:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=3bcf328b9332c8641af38f8523340589&tags=cat"];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
                  
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];

    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler: ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    
        if(error) {
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *dictJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if(jsonError) {
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return;
        }
        
        NSDictionary *photos = [dictJSON valueForKey:@"photos"];
        NSArray *photo = [photos valueForKey:@"photo"];
        
        for(NSDictionary *currentPhoto in photo) {
            
            NSString *myId = [currentPhoto valueForKey:@"id"];
            NSString *owner = [currentPhoto valueForKey:@"owner"];
            NSString *secret = [currentPhoto valueForKey:@"secret"];
            NSString *server = [currentPhoto valueForKey:@"server"];
            NSString *farm = [currentPhoto valueForKey:@"farm"];
            NSString *title = [currentPhoto valueForKey:@"title"];
            NSString *isPublic = [currentPhoto valueForKey:@"ispublic"];
            NSString *isFriend = [currentPhoto valueForKey:@"isfriend"];
            NSString *isFamily = [currentPhoto valueForKey:@"isfamily"];
            
            NSString *urlString = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg", farm, server, myId, secret];
            
            NSURL *url = [NSURL URLWithString:urlString];
            NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
            NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
            NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                
                if(error) {
                    NSLog(@"error: %@", error.localizedDescription);
                    return;
                }
                
                NSData *data = [NSData dataWithContentsOfURL:location];
                UIImage *image = [UIImage imageWithData:data];
                
                Photo *photo = [[Photo alloc]initWithImage:image andTitle:title];
                [self.cats addObject:photo];
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [self.photoCollectionView reloadData];
                }];
                
            }];
            
            [downloadTask resume];
        }
    }];
    
    [dataTask resume];
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
        Photo *photo = [self.cats objectAtIndex:indexPath.item];
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
    return [self.cats count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    Photo *photo = [self.cats objectAtIndex:indexPath.item];
    cell.myPhoto = photo;
    
    return cell;
}


#pragma mark - Helper -

//- (NSArray *)prepareDataSource {
//    
//    Photo *photo1 = [[Photo alloc] initWithImage:[UIImage imageNamed:@"cat-0" ] andTitle:@"cat 0" ];
//    
//    Photo *photo2 = [[Photo alloc] initWithImage:[UIImage imageNamed:@"cat-1" ] andTitle:@"cat 1" ];
//    
//    Photo *photo3 = [[Photo alloc] initWithImage:[UIImage imageNamed:@"cat-2" ] andTitle:@"cat 2" ];
//    
//    NSArray *initialArray = @[photo1, photo2, photo3];
//    
//    return initialArray;
//}

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
