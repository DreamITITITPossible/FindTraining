//
//  MemberDetailsModel.h
//  FindTraining
//
//  Created by Jiang on 16/9/26.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "JiangBaseModel.h"

@interface MemberDetailsModel : JiangBaseModel
@property (nonatomic, assign) BOOL isFriend;
@property (nonatomic, assign) BOOL isBlack;
@property (nonatomic, retain) NSString *memberId;
@property (nonatomic, retain) NSString *headImageUrl;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *age;
@property (nonatomic, retain) NSString *sex;
@property (nonatomic, retain) NSString *roleType;
@property (nonatomic, retain) NSString *realNameAuthentication;
@property (nonatomic, retain) NSString *slogan;
@property (nonatomic, retain) NSString *cityName;
@property (nonatomic, retain) NSString *areaName;
@property (nonatomic, retain) NSString *collectCount;
@property (nonatomic, retain) NSString *isCollect;
@property (nonatomic, retain) NSString *isHot;
@property (nonatomic, retain) NSArray *memberPhotoList;
@property (nonatomic, retain) NSString *memberSkill;
@property (nonatomic, retain) NSString *mentorIntro;
@property (nonatomic, retain) NSString *mentorScore;
@property (nonatomic, retain) NSString *isSign;
@property (nonatomic, retain) NSString *mentorSkill;
@property (nonatomic, retain) NSString *trainerIntro;
@property (nonatomic, retain) NSString *trainerScore;
@property (nonatomic, retain) NSString *trainerSkill;
@property (nonatomic, retain) NSString *allScore;


@end