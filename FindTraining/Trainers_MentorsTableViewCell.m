//
//  Trainers_MentorsTableViewCell.m
//  FindTraining
//
//  Created by Jiang on 16/9/24.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "Trainers_MentorsTableViewCell.h"
#import "MentorsModel.h"
#import "TrainersModel.h"
#import "Sex_AgeView.h"
#import "ScoreView.h"
#import "DistanceView.h"
#import "RoleTypeView.h"

@interface Trainers_MentorsTableViewCell ()
@property (nonatomic, retain) UIImageView *headImageView;
@property (nonatomic, retain) ScoreView *scoreView;
@property (nonatomic, retain) UILabel *nickNameLabel;
@property (nonatomic, retain) RoleTypeView *roleView;
@property (nonatomic, retain) Sex_AgeView *sex_AgeView;
@property (nonatomic, retain) UILabel *student_meetLabel;
@property (nonatomic, retain) UILabel *introductionLabel;
@property (nonatomic, retain) DistanceView *distanceView;
@property (nonatomic, retain) UILabel *collectionLabel;
@property (nonatomic, retain) UIImageView *collectionImage;
@end

@implementation Trainers_MentorsTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.headImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_headImageView];
       _headImageView.layer.cornerRadius = 40;
        _headImageView.clipsToBounds = YES;
        
        self.scoreView = [[ScoreView alloc] init];
        [self.contentView addSubview:_scoreView];
        
        self.nickNameLabel = [[UILabel alloc] init];
        _nickNameLabel.font = kFONT_SIZE_18;
        _nickNameLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_nickNameLabel];
       
        
        
        self.sex_AgeView = [[Sex_AgeView alloc] init];
        [self.contentView addSubview:_sex_AgeView];
        
        self.roleView = [[RoleTypeView alloc] init];
        [self.contentView addSubview:_roleView];
        
        self.student_meetLabel = [[UILabel alloc] init];
        _student_meetLabel.font = kFONT_SIZE_13;
        [self.contentView addSubview:_student_meetLabel];
        
        self.introductionLabel = [[UILabel alloc] init];
        _introductionLabel.font = kFONT_SIZE_15;
        [self.contentView addSubview:_introductionLabel];
        self.distanceView = [[DistanceView alloc]init];
        [self.contentView addSubview:_distanceView];
        self.collectionImage = [[UIImageView alloc] init];
        _collectionImage.image = [UIImage imageNamed:@"Unknown-1"];
        [self.contentView addSubview:_collectionImage];
        self.collectionLabel = [[UILabel alloc] init];
        _collectionLabel.font = kFONT_SIZE_13;
        _collectionLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_collectionLabel];
        
        
    }
    return self;
}
- (void)setTrainersModel:(TrainersModel *)trainersModel {
    if (_trainersModel != trainersModel) {
        _trainersModel = trainersModel;
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:trainersModel.headImageUrl] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        _nickNameLabel.text = _trainersModel.nickName;
        _sex_AgeView.sex = _trainersModel.sex;
        _sex_AgeView.age = _trainersModel.age;
        _distanceView.distance = _trainersModel.juli;
        _roleView.roleType = _trainersModel.roleType;
        _student_meetLabel.text = [NSString stringWithFormat:@"学员数%@人", _trainersModel.studentCount];
        _collectionLabel.text = _trainersModel.collectCount;
        _introductionLabel.text = _trainersModel.introduction;
        _scoreView.score = trainersModel.score;
        
        
    }
}
- (void)setMentorsModel:(MentorsModel *)mentorsModel {
    if (_mentorsModel != mentorsModel) {
        _mentorsModel = mentorsModel;
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    _headImageView.frame = CGRectMake(25, 20, 80, 80);
    
    _scoreView.frame = CGRectMake(_headImageView.frame.origin.x + _headImageView.frame.size.width / 2 - 30, _headImageView.frame.origin.y + _headImageView.frame.size.height + 25, 60, 8);
    CGFloat nickNameWidth = [UILabel getWidthWithTitle:_nickNameLabel.text font:kFONT_SIZE_18];
    _nickNameLabel.frame = CGRectMake(_headImageView.frame.origin.x + _headImageView.frame.size.width + 20, _headImageView.frame.origin.y - 5, nickNameWidth, 20);
    
    _sex_AgeView.frame = CGRectMake(_nickNameLabel.frame.origin.x + _nickNameLabel.frame.size.width + 10, _nickNameLabel.frame.origin.y, 50, _nickNameLabel.frame.size.height);
    _distanceView.frame = CGRectMake(SCREEN_WIDTH - 90, _nickNameLabel.frame.origin.y , 70, _nickNameLabel.frame.size.height);
    _roleView.frame = CGRectMake(_nickNameLabel.frame.origin.x, _nickNameLabel.frame.origin.y + _nickNameLabel.frame.size.height + 20, 100, 20);
    CGFloat student_meetWidth = [UILabel getWidthWithTitle:_student_meetLabel.text font:kFONT_SIZE_13];
    _student_meetLabel.frame = CGRectMake(_nickNameLabel.frame.origin.x, _roleView.frame.origin.y + _roleView.frame.size.height + 20, student_meetWidth, 20);
    CGFloat collectionWidth = [UILabel getWidthWithTitle:_collectionLabel.text font:kFONT_SIZE_15];

    _collectionLabel.frame = CGRectMake(SCREEN_WIDTH - collectionWidth - 20, _student_meetLabel.frame.origin.y, collectionWidth, 20);
    _collectionImage.frame = CGRectMake(_collectionLabel.frame.origin.x - 20, _collectionLabel.origin.y + 2, 16, 16);
    
    _introductionLabel.frame = CGRectMake(_student_meetLabel.frame.origin.x, _scoreView.frame.origin.y, SCREEN_WIDTH - _student_meetLabel.frame.origin.x - 20, 20);
    
    
    

    
    
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
