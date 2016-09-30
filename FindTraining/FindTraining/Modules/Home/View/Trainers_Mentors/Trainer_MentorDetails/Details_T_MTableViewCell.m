//
//  Details_T_MTableViewCell.m
//  FindTraining
//
//  Created by Jiang on 16/9/29.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "Details_T_MTableViewCell.h"
#import "Title_SkillView.h"
#import "Title_ScoreView.h"
#import "Title_ContentView.h"

@interface Details_T_MTableViewCell ()
@property (nonatomic, retain) Title_SkillView *skillView;
@property (nonatomic, retain) Title_ScoreView *scoreView;
@property (nonatomic, retain) Title_ContentView *introView;
@property (nonatomic, retain) NSArray *skillArray;

@end

@implementation Details_T_MTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.skillView = [[Title_SkillView alloc] init];
        [self.contentView addSubview:_skillView];
        self.scoreView = [[Title_ScoreView alloc] init];
        [self.contentView addSubview:_scoreView];
        self.introView = [[Title_ContentView alloc] init];
        [self.contentView addSubview:_introView];
        
        
        
        
        
    }
    return self;
}
- (void)setSkillTitle:(NSString *)skillTitle {
    if (_skillTitle != skillTitle) {
        _skillTitle = skillTitle;
    }
    _skillView.title = _skillTitle;
}

- (void)setScoreTitle:(NSString *)scoreTitle {
    if (_scoreTitle != scoreTitle) {
        _scoreTitle = scoreTitle;
        _scoreView.title = _scoreTitle;
    }
}

- (void)setIntroTitle:(NSString *)introTitle {
    if (_introTitle != introTitle) {
        _introTitle = introTitle;
        _introView.title = _introTitle;
    }
}
- (void)setMemberDetails:(MemberDetailsModel *)memberDetails {
    if (_memberDetails != memberDetails) {
        _memberDetails = memberDetails;
    }
    if ([_segmenTitle isEqualToString:@"教练"]) {
        _skillView.memberSkill = _memberDetails.trainerSkill;
        _scoreView.score = _memberDetails.trainerScore;
        _introView.content = _memberDetails.trainerIntro;
    } else if ([_segmenTitle isEqualToString:@"陪练"]) {
        _skillView.memberSkill = _memberDetails.mentorSkill;
        _scoreView.score = _memberDetails.mentorScore;
        _introView.content = _memberDetails.mentorIntro;
        
    }
    
    
}
- (void)setSegmenTitle:(NSString *)segmenTitle {
    if (_segmenTitle != segmenTitle) {
        _segmenTitle = segmenTitle;
        
    }

}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if ([_segmenTitle isEqualToString:@"教练"]) {
    self.skillArray = [_memberDetails.trainerSkill componentsSeparatedByString:@","];
    } else if ([_segmenTitle isEqualToString:@"陪练"]) {
        
    self.skillArray = [_skillView.memberSkill componentsSeparatedByString:@","];
        _introView.content = _memberDetails.mentorIntro;
        
    }

    NSInteger count =  _skillArray.count / 3;
    if (_skillArray.count % 3 > 0) {
        count = count + 1;
    }
    if (_skillArray.count == 0) {
        count = 0;
    }
    _skillView.frame = CGRectMake(5, 10, SCREEN_WIDTH - 10, 45 * count);
    _scoreView.frame = CGRectMake(_skillView.frame.origin.x, _skillView.frame.origin.y + _skillView.frame.size.height + 10, _skillView.frame.size.width, 30);
    CGFloat introHeight = [UILabel getHeightByWidth:_scoreView.frame.size.width title:_introView.content font:kFONT_SIZE_15_BOLD];
    _introView.frame = CGRectMake(_scoreView.frame.origin.x, _scoreView.frame.origin.y + _scoreView.frame.size.height + 10, _scoreView.frame.size.width, introHeight);

}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
