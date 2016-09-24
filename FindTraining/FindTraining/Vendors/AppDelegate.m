//
//  AppDelegate.m
//  FindTraining
//
//  Created by Jiang on 16/9/20.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "AppDelegate.h"
#import "NSDate+Categories.h"
#import "HomeViewController.h"
#import "LoginViewController.h"
#import "CommunicationViewController.h"
#import "MineViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
#pragma mark - 捕获异常信息

void uncaughtExceptionHandler(NSException *exception) {
    
    // 异常的堆栈信息
    NSArray *stackArray = [exception callStackSymbols];
    // 出现异常的原因
    NSString *reason = [exception reason];
    // 异常名称
    NSString *name = [exception name];
    
    NSString *syserror = [NSString stringWithFormat:@"异常名称：%@\n异常原因：%@\n异常堆栈信息：%@", name, reason, stackArray];
    DDLogInfo(@"CRASH: %@", syserror);
    
    NSString *dirName = @"exception";
    NSString *fileDir = [NSString stringWithFormat:@"%@/%@/", [FileManagerUtils getDocumentsPath], dirName];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:fileDir isDirectory:&isDir];
    if (!(isDir && existed)) {
        [fileManager createDirectoryAtPath:fileDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    //更改到待操作的目录下
    [fileManager changeCurrentDirectoryPath:[fileDir stringByExpandingTildeInPath]];
    [fileManager createFileAtPath:[fileDir stringByAppendingString:[NSDate getSystemTimeString]] contents:[syserror dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    LoginViewController *loginVC = [[LoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    self.window.rootViewController = nav;
    
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
//    homeVC.title = @"主页";
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    UIImage *homeImage = [UIImage imageNamed:@"home_tabbar_firstpage"];
    homeImage = [homeImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *homeSelectedImage = [UIImage imageNamed:@"home_tabbar_firstpage_red"];
    homeSelectedImage = [homeSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:homeImage selectedImage:homeSelectedImage];
    
    
    CommunicationViewController *communincationVC = [[CommunicationViewController alloc] init];
//    communincationVC.title = @"沟通";
    UINavigationController *communincationNav = [[UINavigationController alloc] initWithRootViewController:communincationVC];
    

    UIImage *communincationImage = [UIImage imageNamed:@"home_tabbar_chat"];
    communincationImage = [communincationImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *communincationSelectedImage = [UIImage imageNamed:@"home_tabbar_chat_red"];
    communincationSelectedImage = [communincationSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    communincationNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:communincationImage selectedImage:communincationSelectedImage];
    
    MineViewController *mineVC = [[MineViewController alloc] init];
//    mineVC.title = @"我的";
    UINavigationController *mineNaV = [[UINavigationController alloc] initWithRootViewController:mineVC];
    UIImage *mineImage = [UIImage imageNamed:@"home_tabbar_mine"];
    mineImage = [mineImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *mineSelectedImage = [UIImage imageNamed:@"home_tabbar_mine_red"];
    mineSelectedImage = [mineSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    mineNaV.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:mineImage selectedImage:mineSelectedImage];
    
    
    
    
    // 创建标签视图控制器
    UITabBarController *rootTabBarController = [[UITabBarController alloc] init];
    // 设置被管理的视图控制器 (或者导航视图控制器)
    rootTabBarController.viewControllers = @[homeNav, communincationNav, mineNaV];
    // tabBar选中颜色
    rootTabBarController.tabBar.tintColor = [UIColor redColor];
    // tabBar背景颜色
    rootTabBarController.tabBar.barTintColor = [UIColor whiteColor];
//    rootTabBarController.tabBarItem.imageInsets = UIEdgeInsetsMake(20, 20, 20, 20);
//    rootTabBarController.tabBarItem.titlePositionAdjustment = UIOffsetMake(10, 10);
    
    // 是否半透明
    //    rootTabBarController.tabBar.translucent = NO;

//    self.window.rootViewController = rootTabBarController;
    
    
    
    
    
    
    
    [self DDLogsetup];
    [self initMobClick];
    
    NSLog(@"NSLog");
    DDLogVerbose(@"Verbose");
    DDLogDebug(@"Debug");
    DDLogInfo(@"Info");
    DDLogWarn(@"Warn");
    DDLogError(@"Error");
    
    DDLogError(NSHomeDirectory());
    [self networkReachability];

    return YES;
}
#pragma mark - NetworkReachability

- (void)networkReachability {
    AFNetworkReachabilityManager *mar = [AFNetworkReachabilityManager sharedManager];
    [mar setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: {
                NSLog(@"未使识别的网络");
                break;
            }
            case AFNetworkReachabilityStatusNotReachable: {
                NSLog(@"不可达的（未连接的）");
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN: {
                NSLog(@"2G，3G 4G 网络");
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi: {
                NSLog(@"WIFi");
                break;
            }
        }
    }];
    
    [mar startMonitoring];
}

#pragma makr UMeng

- (void)initMobClick {
    UMConfigInstance.appKey = kUMengAppKey;
    UMConfigInstance.channelId = kUMengChannelId;
    [MobClick startWithConfigure:UMConfigInstance];
}

#pragma mark setup

- (void)DDLogsetup {
    
    //    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    
    //开启使用 XcodeColors
    setenv("XcodeColors", "YES", 0);
    //检测
    char *xcode_colors = getenv("XcodeColors");
    if (xcode_colors && (strcmp(xcode_colors, "YES") == 0))
    {
        // XcodeColors is installed and enabled!
        NSLog(@"XcodeColors is installed and enabled");
    }
    
    //开启DDLog 颜色
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor blueColor] backgroundColor:nil forFlag:DDLogFlagVerbose];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor brownColor] backgroundColor:nil forFlag:DDLogFlagDebug];
    
    //配置DDLog
    [DDLog addLogger:[DDTTYLogger sharedInstance]]; // TTY = Xcode console
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
