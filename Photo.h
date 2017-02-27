//
//  Photo.h
//  Cats
//
//  Created by Dave Augerinos on 2017-02-27.
//  Copyright © 2017 Dave Augerinos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@interface Photo : NSObject

@property (nonatomic, strong) UIImage *myImage;
@property (nonatomic, strong) NSString *title;

-(instancetype)initWithImage:(UIImage *)image andTitle:(NSString *)title;

@end
