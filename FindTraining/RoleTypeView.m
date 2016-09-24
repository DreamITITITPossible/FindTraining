//
//  RoleTypeView.m
//  FindTraining
//
//  Created by Jiang on 16/9/24.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "RoleTypeView.h"

@interface RoleTypeView ()
@property (nonatomic, retain) NSMutableArray *roleTypeArray;
@end
@implementation RoleTypeView

- (void)setRoleType:(NSString *)roleType {
    if (_roleType != roleType) {
        _roleType = roleType;
 
    }
    NSArray *array = [NSArray array];
    array = [_roleType componentsSeparatedByString:@","];
    self.roleTypeArray = [NSMutableArray arrayWithArray:array];
    [_roleTypeArray removeObject:@"4"];
    [_roleTypeArray removeObject:@"5"];
    

    
    }
    
}
@end
