//
//  Comment_T_MTableViewCell.m
//  FindTraining
//
//  Created by Jiang on 16/9/29.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "Comment_T_MTableViewCell.h"
#import "ScoreView.h"

@interface Comment_T_MTableViewCell ()
@property (nonatomic, retain) UIImageView *headImageView;
@property (nonatomic, retain) ScoreView *scoreView;
@property (nonatomic, retain) UILabel *contentLabel;
@property (nonatomic, retain) UILabel *trueNameLabel;
@property (nonatomic, retain) UILabel *course_activityNameLabel;
@property (nonatomic, retain) UILabel *timeLabel;
@property (nonatomic, retain) UILabel *nameLabel;

@end
@implementation Comment_T_MTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.headImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_headImageView];
        _headImageView.layer.cornerRadius = 20;
        _headImageView.clipsToBounds = YES;
        [self.contentView addSubview:_headImageView];
        self.scoreView = [[ScoreView alloc] init];
        [self.contentView addSubview:_scoreView];
        self.trueNameLabel = [[UILabel alloc] init];
        _trueNameLabel.font = kFONT_SIZE_15_BOLD;
        [self.contentView addSubview:_trueNameLabel];
        
        self.contentLabel = [[UILabel alloc] init];
        _contentLabel.font = kFONT_SIZE_15_BOLD;
        _contentLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_contentLabel];
        
        self.course_activityNameLabel = [[UILabel alloc] init];
        _course_activityNameLabel.font = kFONT_SIZE_15_BOLD;
        [self.contentView addSubview:_course_activityNameLabel];
        self.timeLabel = [[UILabel alloc] init];
        _timeLabel.font = kFONT_SIZE_15_BOLD;
        [self.contentView addSubview:_timeLabel];
        
        self.nameLabel = [[UILabel alloc] init];
        _nameLabel.font = kFONT_SIZE_15_BOLD;
        [self.contentView addSubview:_nameLabel];

    }
    return self;
    
}
- (void)setM_T_CommentList:(M_T_CommentListModel *)M_T_CommentList {
    if (_M_T_CommentList != M_T_CommentList) {
        _M_T_CommentList = M_T_CommentList;
    }
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:_M_T_CommentList.headImageUrl] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    _scoreView.score = _M_T_CommentList.avgScore;
    _trueNameLabel.text = _M_T_CommentList.trueName;
    _timeLabel.text = _M_T_CommentList.createTime;
    _nameLabel.text = _M_T_CommentList.name;
    _contentLabel.text = _M_T_CommentList.content;
}
- (void)setCourse_ActivityName:(NSString *)course_ActivityName {
    if (_course_ActivityName != course_ActivityName) {
        _course_ActivityName = course_ActivityName;
        
    }
    _course_activityNameLabel.text = _course_ActivityName;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _headImageView.frame = CGRectMake(10, 5, 40, 40);
    CGFloat trueNameWidth = [UILabel getWidthWithTitle:_trueNameLabel.text font:_trueNameLabel.font];
    _trueNameLabel.frame = CGRectMake(_headImageView.frame.origin.x + _headImageView.frame.size.width + 10, _headImageView.frame.origin.y, trueNameWidth, 20);
    
    CGFloat timeWidth = [UILabel getWidthWithTitle:_timeLabel.text font:_timeLabel.font];
    _timeLabel.frame = CGRectMake(_trueNameLabel.frame.origin.x + _trueNameLabel.frame.size.width + 15, _trueNameLabel.frame.origin.y, timeWidth, _trueNameLabel.frame.size.height);
    _scoreView.frame = CGRectMake(SCREEN_WIDTH - 65, _trueNameLabel.frame.origin.y, 50, 20);
    CGFloat coursr_activityWidth = [UILabel getWidthWithTitle:_course_activityNameLabel.text font:_course_activityNameLabel.font];
    _course_activityNameLabel.frame = CGRectMake(_trueNameLabel.frame.origin.x, _trueNameLabel.frame.origin.y + _trueNameLabel.frame.size.height + 5, coursr_activityWidth, _trueNameLabel.frame.size.height);
    CGFloat nameWidth = [UILabel getWidthWithTitle:_nameLabel.text font:_nameLabel.font];
    _nameLabel.frame = CGRectMake(_course_activityNameLabel.frame.origin.x + _course_activityNameLabel.frame.size.width + 5, _course_activityNameLabel.frame.origin.y, nameWidth, _course_activityNameLabel.frame.size.height);
    CGFloat contentWidth = [UILabel getWidthWithTitle:_contentLabel.text font:_contentLabel.font];
    _contentLabel.frame = CGRectMake(_course_activityNameLabel.frame.origin.x, _course_activityNameLabel.frame.origin.y + _course_activityNameLabel.frame.size.height, contentWidth, _course_activityNameLabel.frame.size.height);
    
    
    
    
    
    
    
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
