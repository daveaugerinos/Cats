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
        
        NSMutableArray *resultArray = [NSMutableArray array];
        
        for(NSDictionary *currentPhoto in photo) {
            
            NSString *myId = [currentPhoto valueForKey:@"id"];
//            NSString *owner = [currentPhoto valueForKey:@"owner"];
            NSString *secret = [currentPhoto valueForKey:@"secret"];
            NSString *server = [currentPhoto valueForKey:@"server"];
            NSString *farm = [currentPhoto valueForKey:@"farm"];
            NSString *title = [currentPhoto valueForKey:@"title"];
//            NSString *isPublic = [currentPhoto valueForKey:@"ispublic"];
//            NSString *isFriend = [currentPhoto valueForKey:@"isfriend"];
//            NSString *isFamily = [currentPhoto valueForKey:@"isfamily"];
            
            NSString *urlString = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg", farm, server, myId, secret];
            NSURL *url = [NSURL URLWithString:urlString];
            
            Photo *photo = [[Photo alloc] initWithTitle:title andURL:url];
            [resultArray addObject:photo];
        }
        
        completionHandler(resultArray, nil);
    }];
    
    [dataTask resume];
}

@end
