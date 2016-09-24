//
//  UIBarButtonItem+ButtonImage.h
//  FindTraining
//
//  Created by Jiang on 16/9/23.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

//typedef void(^targetBlock)(NSInteger tag);
typedef void (^Callback)();

@interface UIBarButtonItem (ButtonImage)
+(UIBarButtonItem *)getBarButtonItemWithImageName:(NSString *)imageName HighLightedImageName:(NSString *)imageNameHighlighted targetBlock:(Callback)block;
@end
