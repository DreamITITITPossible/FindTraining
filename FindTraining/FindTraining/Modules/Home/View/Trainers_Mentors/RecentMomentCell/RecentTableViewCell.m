//
//  RecentTableViewCell.m
//  FindTraining
//
//  Created by Jiang on 16/9/28.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "RecentTableViewCell.h"
#import "Title_RecentView.h"

@interface RecentTableViewCell ()
@property (nonatomic, retain) Title_RecentView *titleRecentView;
@end
@implementation RecentTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleRecentView = [[Title_RecentView alloc] init];
        _titleRecentView.title = @"动态 :";
        [self.contentView addSubview:_titleRecentView];
        
    }
    return self;
}

- (void)setRecentMoment:(RecentMomentModel *)recentMoment {
    if (_recentMoment != recentMoment) {
        _recentMoment = recentMoment;
    }
    _titleRecentView.recentMoment = _recentMoment;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _titleRecentView.frame = CGRectMake(5, 0, SCREEN_WIDTH - 10, 70);
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
