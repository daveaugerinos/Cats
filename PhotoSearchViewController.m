//
//  PhotoSearchViewController.m
//  Cats
//
//  Created by Dave Augerinos on 2017-02-28.
//  Copyright © 2017 Dave Augerinos. All rights reserved.
//

#import "PhotoSearchViewController.h"

@interface PhotoSearchViewController ()

@end

@implementation PhotoSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)backButtonTapped:(UIButton *)sender {

    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
