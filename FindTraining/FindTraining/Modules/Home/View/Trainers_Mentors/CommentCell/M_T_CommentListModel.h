//
//  M_T_CommentListModel.h
//  FindTraining
//
//  Created by Jiang on 16/9/29.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface M_T_CommentListModel : NSObject
@property (nonatomic, retain) NSString *ID;
@property (nonatomic, retain) NSString *objectId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) NSString *avgScore;
@property (nonatomic, retain) NSString *objectType;
@property (nonatomic, retain) NSString *createTime;
@property (nonatomic, retain) NSString *trueName;
@property (nonatomic, retain) NSString *headImageUrl;
@property (nonatomic, retain) NSString *memberId;

@end
