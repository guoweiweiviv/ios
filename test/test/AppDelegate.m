//
//  AppDelegate.m
//  test
//
//  Created by gnway on 2018/9/7.
//  Copyright © 2018年 com.gnway. All rights reserved.
//

#import <UserNotifications/UserNotifications.h>
#import "AppDelegate.h"
#import "nav.h"
#import "testVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Override point for customization after application launch.
  // 如果没有触发恢复, 则重新设置根控制器
  
  if (self.window == nil || self.window.rootViewController == nil) {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor greenColor];
    
    testVC *tVC = [[testVC alloc] init];
    tVC.i = 1;
    nav *nv = [[nav alloc] initWithRootViewController:tVC];
    nv.restorationIdentifier = NSStringFromClass([nav class]);
    nv.restorationClass = [nv class];
    self.window.rootViewController = nv;
  }
  
    [self.window makeKeyAndVisible];

  [self setIconBadgeNum];
  [self sendNotifyMsg];
  return YES;
}

-(void) setIconBadgeNum
{
  UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
  UNAuthorizationOptions options = UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert;
  [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
    if (granted) {
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] registerForRemoteNotifications];
      });
    } else
      NSLog(@"%@", error);
  }];
    

  UIApplication *app = [UIApplication sharedApplication];
  // 应用程序右上角数字
  app.applicationIconBadgeNumber = 100;
  
  [center getDeliveredNotificationsWithCompletionHandler:^(NSArray<UNNotification *> * _Nonnull notifications) {
    for (UNNotification *notify in notifications) {
      NSLog(@"%@ %@ %@", notify.request.content.body, notify.request.content.badge, [notify.date description]);
    }
  }];
}

-(void) sendNotifyMsg
{
   UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
  UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
  content.body = @"xxx";
  content.title = @"xxx";
  content.badge = @41;
  
  UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:10.0f repeats:NO];
  UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"com.gnway.bangya1.xxx" content:content trigger:trigger];
  [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
    NSLog(@"%@", error);
  }];
}



- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)token
{
  
  NSString *deviceToken = [[[[token description]
                             stringByReplacingOccurrencesOfString:@"<"withString:@""]
                            stringByReplacingOccurrencesOfString:@">" withString:@""]
                           stringByReplacingOccurrencesOfString: @" " withString: @""];
  NSLog(@"%@", deviceToken);
}


- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


//APP被手动杀死，系统会删除保存的状态，APP再次打开就没有可恢复的状态
//保存状态
- (BOOL) application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder
{
  return YES;
}

//恢复状态
- (BOOL) application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder
{
  return YES;
}


@end
