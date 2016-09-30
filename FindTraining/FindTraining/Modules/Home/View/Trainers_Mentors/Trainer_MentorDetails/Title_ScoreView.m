//
//  Title_ScoreView.m
//  FindTraining
//
//  Created by Jiang on 16/9/29.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "Title_ScoreView.h"
#import "ScoreView.h"

@interface Title_ScoreView ()

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) ScoreView *scoreView;
@end
@implementation Title_ScoreView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [[UILabel alloc] init];
        _titleLabel.font = kFONT_SIZE_15_BOLD;
        [self addSubview:_titleLabel];
        self.scoreView = [[ScoreView alloc] init];
        [self addSubview:_scoreView];
        
        
        
        
    }
    return self;
}
- (void)setTitle:(NSString *)title {
    if (_title != title) {
        _title = title;
    }
    _titleLabel.text = _title;
    CGFloat width = [UILabel getWidthWithTitle:_titleLabel.text font:_titleLabel.font];
    _titleLabel.frame = CGRectMake(0, 0, width, 18);
    
}
- (void)setScore:(NSString *)score {
    if (_score != score) {
        _score = score;
    }
    _scoreView.score = _score;

    _scoreView.frame = CGRectMake(_titleLabel.frame.origin.x + _titleLabel.frame.size.width + 10, _titleLabel.frame.origin.y + 5, SCREEN_WIDTH - _titleLabel.frame.origin.x - _titleLabel.frame.size.width - 10 - 5, 20);
}




@end
