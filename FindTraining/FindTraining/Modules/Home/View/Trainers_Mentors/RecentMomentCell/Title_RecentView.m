//
//  Title_RecentView.m
//  FindTraining
//
//  Created by Jiang on 16/9/28.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "Title_RecentView.h"
#import "RecentView.h"
#import "RecentPersonalView.h"

@interface Title_RecentView ()
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) RecentView *recentView;
@property (nonatomic, retain) RecentPersonalView *recentPersonalView;
@property (nonatomic, retain) UILabel *nullLabel;
@end
@implementation Title_RecentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [[UILabel alloc] init];
        _titleLabel.font = kFONT_SIZE_15_BOLD;
        
        [self addSubview:_titleLabel];
      
    
        
    }
    return self;
}
- (void)setRecentMoment:(RecentMomentModel *)recentMoment {
    if (_recentMoment != recentMoment) {
        _recentMoment = recentMoment;
        
    }
    if ([_recentMoment.type isEqualToString:@"1"]) {
        self.recentPersonalView = [[RecentPersonalView alloc] init];
        _recentPersonalView.recentMoment = _recentMoment;

        [self addSubview:_recentPersonalView];
    } else if ([_recentMoment.type isEqualToString:@"2"]) {
        self.recentView = [[RecentView alloc] init];
        _recentView.recentMoment = _recentMoment;

        [self addSubview:_recentView];
    } else {
        self.nullLabel = [[UILabel alloc] init];
        self.nullLabel.backgroundColor = [UIColor colorWithRed:0.7651 green:0.7651 blue:0.7651 alpha:1.0];
        _nullLabel.text = @"暂无动态";
        _nullLabel.font = kFONT_SIZE_15_BOLD;
//        _nullLabel.numberOfLines = 3;
        _nullLabel.textColor = [UIColor blackColor];

        [self addSubview:_nullLabel];
    }
   
    
}


- (void)setTitle:(NSString *)title {
    if (_title != title) {
        _title = title;
    }
    _titleLabel.text = _title;
   
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = [UILabel getWidthWithTitle:_titleLabel.text font:_titleLabel.font];
    _titleLabel.frame = CGRectMake(0, 0, width, 18);
    if ([_recentMoment.type isEqualToString:@"1"]) {
        _recentPersonalView.frame = CGRectMake(_titleLabel.frame.origin.x + _titleLabel.frame.size.width + 10, 0, self.frame.size.width - _titleLabel.frame.origin.x - _titleLabel.frame.size.width - 20, 80);
    } else if ([_recentMoment.type isEqualToString:@"2"]){
        _recentView.frame = CGRectMake(_titleLabel.frame.origin.x + _titleLabel.frame.size.width + 10, 0, self.frame.size.width - _titleLabel.frame.origin.x - _titleLabel.frame.size.width - 20, 50);
    } else {
        CGFloat nullWidth = [UILabel getWidthWithTitle:_nullLabel.text font:_nullLabel.font];
        _nullLabel.frame = CGRectMake(_titleLabel.frame.origin.x + _titleLabel.frame.size.width + 10, 0, nullWidth, 20);
    }

}






@end
