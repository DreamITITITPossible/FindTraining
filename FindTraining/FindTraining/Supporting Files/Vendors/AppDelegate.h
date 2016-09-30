//
//  AppDelegate.h
//  FindTraining
//
//  Created by Jiang on 16/9/20.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    AFNetworkReachabilityManager *internetReach;
}


@property (strong, nonatomic) UIWindow *window;


@end

