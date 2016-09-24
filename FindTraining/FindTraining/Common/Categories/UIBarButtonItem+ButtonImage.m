//
//  UIBarButtonItem+ButtonImage.m
//  FindTraining
//
//  Created by Jiang on 16/9/23.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "UIBarButtonItem+ButtonImage.h"
#import <objc/runtime.h>
@implementation UIBarButtonItem (ButtonImage)
static char overviewKey;
+(UIBarButtonItem *)getBarButtonItemWithImageName:(NSString *)imageName HighLightedImageName:(NSString *)imageNameHighlighted targetBlock:(Callback)block {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 21, 21);
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:imageNameHighlighted] forState:UIControlStateHighlighted];
    objc_setAssociatedObject(button, &overviewKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);

//    [button removeTarget:self action:@selector(callActionBlock:) forControlEvents:controlEvent];
    [button handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        block();
    }];
//    [button addTarget:self action:@selector(callActionBlock:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return barButtonItem;
    
}
//- (void)callActionBlock:(id)sender {
//    Callback block = (Callback)objc_getAssociatedObject(sender, &overviewKey);
//    if (block) {
//        block();
//    }
//}
@end
