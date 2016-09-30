//
//  RecentMomentModel.h
//  FindTraining
//
//  Created by Jiang on 16/9/28.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecentMomentModel : NSObject
@property (nonatomic, retain) NSString *mcontent;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *objectType;
@property (nonatomic, retain) NSString *objectId;
@property (nonatomic, retain) NSString *replyCount;
@property (nonatomic, retain) NSString *bonusCount;
@property (nonatomic, retain) NSArray *detail;
@property (nonatomic, retain) NSArray *photoList;

@end
