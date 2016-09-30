
//
//  AlbumCollectionViewCell.m
//  FindTraining
//
//  Created by Jiang on 16/9/27.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "AlbumCollectionViewCell.h"

@interface AlbumCollectionViewCell ()
@property (nonatomic, retain) UIImageView *photoImageView;
@end
@implementation AlbumCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.photoImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_photoImageView];
//        _photoImageView.contentMode = UIViewContentModeScaleAspectFit;
        _photoImageView.layer.cornerRadius = 10;
        _photoImageView.clipsToBounds = YES;
    }
    return self;
}
- (void)setMemberPhotoListModel:(MemberPhotoListModel *)memberPhotoListModel {
    if (_memberPhotoListModel != memberPhotoListModel) {
        _memberPhotoListModel = memberPhotoListModel;
    }
          [_photoImageView sd_setImageWithURL:[NSURL URLWithString:memberPhotoListModel.url] placeholderImage:[UIImage imageNamed:@"placeholder"]];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    _photoImageView.frame = self.contentView.bounds;
}



@end