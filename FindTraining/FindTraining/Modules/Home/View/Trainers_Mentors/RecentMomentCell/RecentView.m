//
//  RecentView.m
//  FindTraining
//
//  Created by Jiang on 16/9/28.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "RecentView.h"
#import "DetailsModel.h"

@interface RecentView()
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *priceLabel;
@end
@implementation RecentView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.7651 green:0.7651 blue:0.7651 alpha:1.0];
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.numberOfLines = 1;
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = kFONT_SIZE_15_BOLD;
        [self addSubview:_nameLabel];
        
        self.priceLabel = [[UILabel alloc] init];
        _priceLabel.numberOfLines = 1;
        _priceLabel.textColor = [UIColor blackColor];
        _priceLabel.font = kFONT_SIZE_15_BOLD;
        [self addSubview:_priceLabel];
    
    }
    return self;
}

- (void)setRecentMoment:(RecentMomentModel *)recentMoment {
    if (_recentMoment != recentMoment) {
        _recentMoment = recentMoment;
    }
    DetailsModel *details = _recentMoment.detail[0];
    _nameLabel.text = details.name;
    _priceLabel.text = [NSString stringWithFormat:@"%@元/人", details.price];


}
- (void)layoutSubviews {
    [super layoutSubviews];
    _nameLabel.frame = CGRectMake(0, 0, self.frame.size.width, 20);
    _priceLabel.frame =CGRectMake(0, _nameLabel.frame.origin.y + _nameLabel.frame.size.height, _nameLabel.frame.size.width, 20);
}

@end
