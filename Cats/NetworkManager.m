//
//  NetworkManager.m
//  Cats
//
//  Created by Dave Augerinos on 2017-02-27.
//  Copyright © 2017 Dave Augerinos. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager

- (void)getPhotos:(void (^)(NSMutableArray *photosArray, NSError *error))completionHandler {
    
    NSURL *url = [NSURL URLWithString:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=e404956112e45a37bba6aa39c68c8bb1&tags=cat&has_geo=1&extras=url_m&format=json&nojsoncallback=1"];
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
        
        NSMutableArray *resultArray = [NSMutableArray array];
        
        for(NSDictionary *currentPhoto in photo) {
            
            NSString *title = [currentPhoto valueForKey:@"title"];
            NSString *myID = [currentPhoto valueForKey:@"id"];
            NSString *url_m = [currentPhoto valueForKey:@"url_m"];
            
            NSURL *url = [NSURL URLWithString:url_m];
            
            Photo *photo = [[Photo alloc] initWithTitle:title myID:myID andURL:url];
            [resultArray addObject:photo];
        }
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            completionHandler(resultArray, nil);
        }];

    }];
    
    [dataTask resume];
}

@end
