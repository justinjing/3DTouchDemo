//
//  AppDelegate.m
//  3DTouchDemo
//
//  Created by justinjing on 15/12/5.
//  Copyright © 2015年 justinjing. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setupApplicationShortcutItems];
    
    [self quichActionShortCutItem:launchOptions];

    return YES;
}

- (void)quichActionShortCutItem:(NSDictionary *)launchOptions{
    
    UIApplicationShortcutItem *shortcutItem = [launchOptions objectForKeyedSubscript:UIApplicationLaunchOptionsShortcutItemKey];
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if(strongSelf){
            [self quickActionWithShortcutItem:shortcutItem];
        }
    });
}


- (void)setupApplicationShortcutItems
{
    UIApplicationShortcutIcon *videoIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:@"shortcut_sight_action"];
    UIApplicationShortcutIcon *messageIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:@"shortcut_chat_action"];
    
    NSDictionary *userInfo1 = @{@"key":@"chat"};
    NSDictionary *userInfo2 = @{@"key":@"video"};
    
    
    UIMutableApplicationShortcutItem *messageShortcutItem = [[UIMutableApplicationShortcutItem alloc] initWithType:@"justinjing.chat" localizedTitle:@"新建聊天" localizedSubtitle:@"新建消息页" icon:messageIcon userInfo:userInfo1];
    UIMutableApplicationShortcutItem *videoShortcutItem = [[UIMutableApplicationShortcutItem alloc] initWithType:@"justinjing.video" localizedTitle:@"录制小视频" localizedSubtitle:@"录制朋友圈小视频" icon:videoIcon userInfo:userInfo2];
    
    NSArray *items = @[videoShortcutItem,messageShortcutItem];
    NSArray *exsitItems = [UIApplication sharedApplication].shortcutItems;
    NSArray *updateItems = [exsitItems arrayByAddingObjectsFromArray:items];
    
    [UIApplication sharedApplication].shortcutItems = updateItems;
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


- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
    if(shortcutItem){
     [self quickActionWithShortcutItem:shortcutItem];
    }
    completionHandler(YES);
}


- (void)quickActionWithShortcutItem:(UIApplicationShortcutItem *)shortcutItem
{
    if (shortcutItem.userInfo){
    NSLog(@"open===%@  %@",shortcutItem.type,shortcutItem.userInfo);
    NSDictionary *dic = shortcutItem.userInfo;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:shortcutItem.type
                                                    message:dic[@"key"]
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil, nil];
    [alert show];
    }
}


@end
