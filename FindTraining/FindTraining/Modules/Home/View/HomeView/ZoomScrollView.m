//
//  ZoomScrollView.m
//  FindTraining
//
//  Created by Jiang on 16/9/23.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "ZoomScrollView.h"

@interface ZoomScrollView ()
@property (nonatomic, retain) UIImageView *imageView;

@end
@implementation ZoomScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:_imageView];
    }
    return self;
}
- (void)setImageURL:(NSString *)imageURL {
    if (_imageURL != imageURL) {
        _imageURL = imageURL;
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:_imageURL] placeholderImage:[UIImage imageNamed:@"downlaod_picture_fail"]];
    }
}



@end
