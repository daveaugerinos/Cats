//
//  Photo.m
//  Cats
//
//  Created by Dave Augerinos on 2017-02-27.
//  Copyright © 2017 Dave Augerinos. All rights reserved.
//

#import "Photo.h"

@implementation Photo

- (instancetype)initWithTitle:(NSString *)title myID:(NSString *) myID andURL:(NSURL *)url
{
    self = [super init];
    if (self) {
        self.myTitle = title;
        self.myURL = url;
        self.myID = myID;
    }
    return self;
}

@end
