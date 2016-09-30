//
//  ScoreView.m
//  FindTraining
//
//  Created by Jiang on 16/9/24.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "ScoreView.h"

@interface ScoreView ()
@property (nonatomic, retain) UIImageView *scoreImageView;
@property (nonatomic, assign) CGRect imageRect;
@property (nonatomic, assign) CGFloat num;
@end

@implementation ScoreView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        for (int i = 0; i < 5; i++) {
            self.scoreImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_star_hollow"]];
            if (i == 0) {
                _scoreImageView.frame = CGRectMake(0, 0, 8, 8);
            }
            _scoreImageView.frame = CGRectMake(_imageRect.size.width + _imageRect.origin.x + 3, 0, 8, 8);
            _scoreImageView.tag = 1020 + i;
            self.imageRect = _scoreImageView.frame;

            [self addSubview:_scoreImageView];
        }
    }
    return self;
}

- (void)setScore:(NSString *)score {
    if (_score != score) {
        _score = score;
}
    _num = [_score floatValue];
    NSInteger allfull = _num / 5;
    NSInteger full = (int)_num % 5;
    if (allfull == 1) {
        full = 5;
    }
    UIImageView *imageView = [[UIImageView alloc] init];
    for (int i = 0; i < full; i++) {
        imageView = [self viewWithTag:1020 + i];
        imageView.image = [UIImage imageNamed:@"icon_star_full"];
    }
    if (_num - full > 0) {
        imageView = [self viewWithTag:1020 + full];
        imageView.image = [UIImage imageNamed:@"icon_star_half"];
    }
}





@end
