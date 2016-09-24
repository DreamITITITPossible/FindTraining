//
//  HomeCollectionViewCell.m
//  FindTraining
//
//  Created by Jiang on 16/9/23.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "HomeCollectionViewCell.h"

@interface HomeCollectionViewCell ()
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UILabel *label;
@end
@implementation HomeCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_imageView];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}
- (void)setImageName:(NSString *)imageName {
    if (_imageName != imageName) {
        _imageName = imageName;
        _imageView.image = [UIImage imageNamed:_imageName];
    }
}
@end
