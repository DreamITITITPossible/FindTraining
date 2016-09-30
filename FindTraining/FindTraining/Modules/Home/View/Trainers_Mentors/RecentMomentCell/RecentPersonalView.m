//
//  RecentPersonalView.m
//  FindTraining
//
//  Created by Jiang on 16/9/28.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "RecentPersonalView.h"
#import "AlbumCollectionViewCell.h"
#import "PhotoListModel.h"

@interface RecentPersonalView ()

@property (nonatomic, retain) UILabel *mcontentLabel;
@property (nonatomic, retain) UIImageView *albumImageView;

@end
@implementation RecentPersonalView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.7651 green:0.7651 blue:0.7651 alpha:1.0];
        self.mcontentLabel = [[UILabel alloc] init];
        _mcontentLabel.font = kFONT_SIZE_15_BOLD;
        _mcontentLabel.textColor = [UIColor blackColor];
        _mcontentLabel.numberOfLines = 1;
        [self addSubview:_mcontentLabel];
        self.albumImageView = [[UIImageView alloc] init];
        [self addSubview:_albumImageView];
        
    }
    return self;
}

- (void)setRecentMoment:(RecentMomentModel *)recentMoment {
    if (_recentMoment != recentMoment) {
        _recentMoment = recentMoment;
    }
    _mcontentLabel.text = _recentMoment.mcontent;
    if (recentMoment.photoList.count > 0) {
        PhotoListModel *photoList = recentMoment.photoList[0];
        [_albumImageView sd_setImageWithURL:[NSURL URLWithString:photoList.url]];
        
    }
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.mcontentLabel.frame = CGRectMake(0, 0, self.bounds.size.width, 20);
    self.albumImageView.frame = CGRectMake(0, _mcontentLabel.frame.origin.y + _mcontentLabel.frame.size.height + 10, 50, 50);
}


@end
