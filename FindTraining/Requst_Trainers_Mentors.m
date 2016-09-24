//
//  Requst_Trainers_Mentors.m
//  FindTraining
//
//  Created by Jiang on 16/9/24.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "Requst_Trainers_Mentors.h"

@implementation Requst_Trainers_Mentors
@synthesize longs = _longs;


- (void)setLongs:(NSString *)longs {
    if (_longs != longs) {
        
        _longs = longs;
    }
}
- (NSString *)longs {
    return _longs;
}


@end
