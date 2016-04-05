//
//  AppDelegate.h
//  MyQRCode
//
//  Created by Leo on 16/3/29.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, copy) void (^reloadStoryPhotos)(void);

@property (nonatomic, assign) BOOL firstLuanch;

@end

