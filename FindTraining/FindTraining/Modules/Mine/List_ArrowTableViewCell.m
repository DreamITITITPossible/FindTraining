//
//  List_ArrowTableViewCell.m
//  FindTraining
//
//  Created by Jiang on 16/9/29.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "List_ArrowTableViewCell.h"
@interface List_ArrowTableViewCell ()

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIImageView *rightImageView;
@end
@implementation List_ArrowTableViewCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLabel];
        
        self.rightImageView = [[UIImageView alloc] init];
        _rightImageView.image = [UIImage imageNamed:@"common_icon_arrow"];
        [self.contentView addSubview:_rightImageView];
        
    }
    return self;
}
- (void)setListTitle:(NSString *)listTitle {
    if (_listTitle != listTitle) {
        _listTitle = listTitle;
    }
    _titleLabel.text = listTitle;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat labelWidth = [UILabel getWidthWithTitle:_titleLabel.text font:_titleLabel.font];
    _titleLabel.frame = CGRectMake(5, 5, labelWidth, 20);
    _rightImageView.frame = CGRectMake(SCREEN_WIDTH - 5 - 24, 3, 24, 24);
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
