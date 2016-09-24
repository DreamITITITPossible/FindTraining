//
//  UIView+ShowMessage.m
//  FindTraining
//
//  Created by Jiang on 16/9/23.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "UIView+ShowMessage.h"


@implementation UIView (ShowMessage)
+(void)showMessage:(NSString *)message
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    UIView *showview =  [[UIView alloc]init];
    showview.backgroundColor = [UIColor blackColor];
    showview.frame = CGRectMake(1, 1, 1, 1);
    showview.alpha = 1.0f;
    showview.layer.cornerRadius = 5.0f;
    showview.layer.masksToBounds = YES;
    [window addSubview:showview];
    
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:16];
    CGFloat width = [UILabel getWidthWithTitle:message font:label.font];
    
    
    label.frame = CGRectMake(10, 5, width, 16);
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.backgroundColor = [UIColor clearColor];
    [showview addSubview:label];
    showview.frame = CGRectMake((SCREEN_WIDTH - width - 20)/2, SCREEN_HEIGHT / 2 + 100, width + 20, 25);
    [UIView animateWithDuration:2 animations:^{
        showview.frame = CGRectMake((SCREEN_WIDTH - width - 20)/2, SCREEN_HEIGHT / 2 + 70, width + 20, 25);
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
    }];
}
@end
