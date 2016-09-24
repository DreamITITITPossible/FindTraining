//
//  Register_ForgetBaseView.h
//  FindTraining
//
//  Created by Jiang on 16/9/21.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "JiangBaseView.h"

@protocol Register_ForgetBaseViewDelegate <NSObject>

- (void)getVerifyCode: (NSInteger)tag;
- (void)nextStep: (NSInteger)tag;
@end

@interface Register_ForgetBaseView : JiangBaseView
@property (nonatomic, assign) id<Register_ForgetBaseViewDelegate>delegate;
@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) NSString *buttonTitle;
@property (nonatomic, retain) NSString *cellphoneText;
@property (nonatomic, retain) NSString *verifyCodeText;
@property (nonatomic, retain) NSString *password_InvitationCodeText;
- (void)startTime;
@end

