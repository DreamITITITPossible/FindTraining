//
//  SkillDataModel.h
//  FindTraining
//
//  Created by Jiang on 16/9/22.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChildrenModel.h"
@interface SkillDataModel : NSObject
@property (nonatomic, copy)NSString *myId;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, retain)NSMutableArray *children;
@end
