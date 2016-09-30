//
//  AlbumZoomScrollView.m
//  FindTraining
//
//  Created by Jiang on 16/9/28.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "AlbumZoomScrollView.h"
@interface AlbumZoomScrollView ()
@property (nonatomic, retain) UIImageView *imageView;
@end
@implementation AlbumZoomScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 32)];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:_imageView];
    }
    return self;
}
- (void)setPhotoList:(MemberPhotoListModel *)photoList {
    if (_photoList != photoList) {
        _photoList = photoList;
    }
      [_imageView sd_setImageWithURL:[NSURL URLWithString:_photoList.url] placeholderImage:[UIImage imageNamed:@"placeholder"]];
   

}


@end
