//
//  ChildrenModel.h
//  FindTraining
//
//  Created by Jiang on 16/9/22.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChildrenModel : NSObject
@property (nonatomic, copy)NSString *myId;
@property (nonatomic, assign)NSInteger parentId;
@property (nonatomic, copy)NSString *name;
@end
