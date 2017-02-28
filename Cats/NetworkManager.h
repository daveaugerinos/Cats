//
//  NetworkManager.h
//  Cats
//
//  Created by Dave Augerinos on 2017-02-27.
//  Copyright © 2017 Dave Augerinos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"

@interface NetworkManager : NSObject

- (void)getPhotos:(void (^)(NSMutableArray *cats, NSError *error))completionHandler;

@end
