//
//  Photo.h
//  Cats
//
//  Created by Dave Augerinos on 2017-02-27.
//  Copyright © 2017 Dave Augerinos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
#import "MapKit/MapKit.h"

@interface Photo : NSObject <MKAnnotation>

@property (nonatomic, strong) UIImage *myImage;
@property (nonatomic, strong) NSString *myTitle;
@property (nonatomic, strong) NSString *myID;
@property (nonatomic, strong) NSURL *myURL;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

- (instancetype)initWithTitle:(NSString *)title myID:(NSString *) myID andURL:(NSURL *)url;

@end
