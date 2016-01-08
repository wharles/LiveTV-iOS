//
//  AppDelegate.m
//  LiveTV
//
//  Created by Koudai on 15/12/17.
//  Copyright © 2015年 Charlies Wang. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarViewController.h"
#import "GlobalMacro.h"

#import <HexColors/HexColor.h>
#import "TSMessage.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    TabBarViewController* rootVC = [[TabBarViewController alloc]init];
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:rootVC];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    [self setDefaultStyle];
    
    [TSMessage setDefaultViewController:self.window.rootViewController];
    
    return YES;
}

/**
 设置全局的风格
 **/
- (void)setDefaultStyle {
    [UINavigationBar appearance].tintColor = MAINCOLOR;
    [UINavigationBar appearance].barTintColor = [HXColor colorWithHexString:BARTINTCOLOR alpha:0.3];
    //custom bar font
    UIFont* barFont = [UIFont fontWithName:@"AvenirNextCondensed-Medium" size:22.0];
    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName:MAINCOLOR,NSFontAttributeName:barFont};
    //change style of status bar
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //style of tool bar
    [UIBarButtonItem appearance].tintColor = [HXColor colorWithHexString:BUTTONTINTCOLOR];
    [UIToolbar appearance].barTintColor = [HXColor colorWithHexString:TOOLBARTINTCOLOR alpha:0.5];
    //custom tab bar
    [UITabBar appearance].tintColor = [HXColor colorWithHexString:TABBARTINTCOLOR];
    [UITabBar appearance].barTintColor = [HXColor colorWithHexString:TABBARBARTINTCOLOR];
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
