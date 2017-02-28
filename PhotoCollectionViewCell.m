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
    
    [self downloadImage];
    [self downloadGeoLocationData];
}

- (void)downloadImage {
    
    NSURL *url = self.myPhoto.myURL;
    
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
            self.photoTitleLabel.text = self.myPhoto.myTitle;
        }];
    }];
    
    [downloadTask resume];
}

- (void)downloadGeoLocationData {
    
    NSURL *url = [self generateURLFromPhotoID];
    
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
        
        NSDictionary *photo = [dictJSON valueForKey:@"photo"];
        NSDictionary *location = [photo valueForKey:@"location"];

        NSString *latitude = [location valueForKey:@"latitude"];
        NSString *longitude = [location valueForKey:@"longitude"];
        
        if(latitude && longitude) {
            
            double lat = [latitude doubleValue];
            double lon = [longitude doubleValue];
            self.myPhoto.coordinate = CLLocationCoordinate2DMake(lat, lon);
        }
    }];
    
    [dataTask resume];
}

- (NSURL *)generateURLFromPhotoID {
    
    NSString *photoID = self.myPhoto.myID;
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] init];
    urlComponents.scheme = @"https";
    urlComponents.host = @"api.flickr.com";
    urlComponents.path = @"/services/rest/";
    NSURLQueryItem *item1 = [[NSURLQueryItem alloc] initWithName:@"method" value:@"flickr.photos.geo.getLocation"];
    NSURLQueryItem *item2 = [[NSURLQueryItem alloc] initWithName:@"api_key" value:@"e404956112e45a37bba6aa39c68c8bb1"];
    NSURLQueryItem *item3 = [[NSURLQueryItem alloc] initWithName:@"photo_id" value:photoID];
    NSURLQueryItem *item4 = [[NSURLQueryItem alloc] initWithName:@"format" value:@"json"];
    NSURLQueryItem *item5 = [[NSURLQueryItem alloc] initWithName:@"nojsoncallback" value:@"1"];
    urlComponents.queryItems = @[item1, item2, item3, item4, item5];
    
    return [urlComponents URL];
}

@end
