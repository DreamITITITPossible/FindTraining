//
//  VerifyCodeModel.h
//  FindTraining
//
//  Created by Jiang on 16/9/21.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "JiangBaseModel.h"

@interface VerifyCodeModel : JiangBaseModel
@property (nonatomic, retain) NSString *cellphone;
@property (nonatomic, retain) NSString *verifyCode;
@property (nonatomic, retain) NSString *invCode;
@property (nonatomic, retain) NSString *timeStamp;
@property (nonatomic, retain) NSString *summary;
@end
