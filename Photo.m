//
//  Photo.m
//  Cats
//
//  Created by Dave Augerinos on 2017-02-27.
//  Copyright © 2017 Dave Augerinos. All rights reserved.
//

#import "Photo.h"

@implementation Photo

-(instancetype)initWithImage:(UIImage *)image andTitle:(NSString *)title {
    
    self = [super init];
    
    if(self) {
        self.myImage = image;
        self.title = title;
    }
    return self;
}

@end
