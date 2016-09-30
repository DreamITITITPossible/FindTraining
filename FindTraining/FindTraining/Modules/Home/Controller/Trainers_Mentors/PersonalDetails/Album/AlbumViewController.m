//
//  AlbumViewController.m
//  FindTraining
//
//  Created by Jiang on 16/9/28.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "AlbumViewController.h"
#import "AlbumView.h"
@interface AlbumViewController ()

@end

@implementation AlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    
//    NSLog(@"~~~~~~~%f %f", self.view.frame.size.height, self.view.frame.origin.y);
//    NSLog(@"!!!!!%f %f", self.view.bounds.size.height, self.view.bounds.origin.y);
    AlbumView *albumView = [[AlbumView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
    albumView.imageArray = _albumArray;
    albumView.currentNum = _currentImage;
//    albumView.center = self.view.center;
    [self.view addSubview:albumView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
