//
//  Title_ContentView.m
//  FindTraining
//
//  Created by Jiang on 16/9/28.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "Title_ContentView.h"
@interface Title_ContentView ()
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *contentLabel;
@end
@implementation Title_ContentView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [[UILabel alloc] init];
        _titleLabel.font = kFONT_SIZE_15_BOLD;
        
        [self addSubview:_titleLabel];
        
        self.contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = [UIColor lightGrayColor];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textAlignment = NSTextAlignmentJustified;
        _contentLabel.font = kFONT_SIZE_15_BOLD;
        [self addSubview:_contentLabel];
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
- (void)setContent:(NSString *)content {
    if (_content != content) {
        _content = content;
    }
    _contentLabel.text = _content;
    CGFloat height = [UILabel getHeightByWidth:SCREEN_WIDTH - _titleLabel.frame.origin.x - _titleLabel.frame.size.width - 10 - 10 title:_content font:_contentLabel.font];
  _contentLabel.frame = CGRectMake(_titleLabel.frame.origin.x + _titleLabel.frame.size.width + 10, 0, SCREEN_WIDTH - _titleLabel.frame.origin.x - _titleLabel.frame.size.width - 10 - 20, height);

}

@end
