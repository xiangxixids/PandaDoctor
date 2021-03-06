//
//  PandaAppDelegate.m
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/7/13.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import "PandaAppDelegate.h"
#import "UtilTool.h"
#import "PandaWebViewTestViewController.h"

@implementation PandaAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    self.loginViewController = [[PandaLoginViewController alloc]initWithNibName:nil bundle:nil];
    
    
    // 以下部分, 仅供测试使用.
//    PandaWebViewTestViewController *controller = [[PandaWebViewTestViewController alloc]initWithNibName:nil bundle:nil];
//    
//    [self initWindows:controller];
//    return YES;
    
    if ([[UtilTool globalDataGet:LOGIN] isEqual:@"1"]) {
        UIStoryboard *storyBorad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.window.rootViewController = [storyBorad instantiateInitialViewController];
        //[self initWindows:[storyBorad instantiateInitialViewController]];
    }else{
        [self initWindows:self.loginViewController];
    }
    
    return YES;
}

- (void)initWindows:(UIViewController*)_controller
{
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.navigationController = [[UINavigationController alloc]initWithRootViewController:_controller];
    //self.navigationController = [[PandaNaviViewController alloc]initWithRootViewController:_controller];
    
    [self.navigationController.navigationBar setHidden:YES];
    
    self.window.rootViewController = self.navigationController;
    
    [self.window setRootViewController:self.navigationController];
    
    [self.window makeKeyAndVisible];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
