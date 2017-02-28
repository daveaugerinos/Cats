//
//  Photo.m
//  Cats
//
//  Created by Dave Augerinos on 2017-02-27.
//  Copyright © 2017 Dave Augerinos. All rights reserved.
//

#import "Photo.h"

@implementation Photo

- (instancetype)initWithTitle:(NSString *)title andURL:(NSURL *)url
{
    self = [super init];
    if (self) {
        self.title = title;
        self.url = url;
    }
    return self;
}

@end
