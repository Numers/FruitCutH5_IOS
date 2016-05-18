/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

//
//  AppDelegate.m
//  FruitCutH5
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright ___ORGANIZATIONNAME___ ___YEAR___. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "BluetoothMacManager.h"

#import "LoadingView.h"

#define AnimateDuration 2.5f
@implementation AppDelegate

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deliveryData:) name:BluetoothDeliveryDataNotify object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bluetoothPowerOn:) name:kBluetoothPowerOnNotify object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bluetoothPowerOff:) name:kBluetoothPowerOffNotify object:nil];
    [[BluetoothMacManager defaultManager] startBluetoothDevice];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    self.window = [[UIWindow alloc] initWithFrame:screenBounds];
    self.window.autoresizesSubviews = YES;
    loadingView = [[LoadingView alloc] initWithFrame:screenBounds];
    loadingView.autoresizesSubviews = YES;
//    [self.window addSubview:loadingView];
    [self.window bringSubviewToFront:loadingView];
    [self.window makeKeyAndVisible];
//    self.viewController = [[MainViewController alloc] init];
//    return [super application:application didFinishLaunchingWithOptions:launchOptions];
    return YES;
}

#pragma -mark Notification
-(void)bluetoothPowerOn:(NSNotification *)notify
{
    [self connectToBluetooth];
    if (timer) {
        if ([timer isValid]) {
            [timer invalidate];
            timer = nil;
        }
    }
    
    timer = [NSTimer scheduledTimerWithTimeInterval:ConnectTimeOut + 3.0f target:self selector:@selector(connectToBluetooth) userInfo:nil repeats:YES];
    [timer fire];
}

-(void)bluetoothPowerOff:(NSNotification *)notify
{
    if (timer) {
        if ([timer isValid]) {
            [timer invalidate];
            timer = nil;
        }
    }
}

-(void)deliveryData:(NSNotification *)notify
{
    NSData *data = [notify object];
    Byte *byte = (Byte *)[data bytes];
    if (data.length > 2) {
        int code = (int)byte[1];
        BluetoothCommand command = (BluetoothCommand)code;
        //返回data解析出来的对应响应指令
        if (command == CommandSmellClose) {
            
        }else{
            
        }
    }
}

#pragma -mark private function
//连接智能设备蓝牙
-(void)connectToBluetooth
{
    if ([[BluetoothMacManager defaultManager] isConnected]) {
        return;
    }
    
    [[BluetoothMacManager defaultManager] startScanBluetoothDevice:ConnectToDevice callBack:^(BOOL completely, CallbackType backType, id obj, ConnectType connectType) {
        if (completely) {
            
            [self hiddenLoadingView];
            
            self.viewController = [[MainViewController alloc] init];
            self.window.rootViewController = self.viewController;
            
        }else{
            if(backType == CallbackBluetoothPowerOff)
            {
                
            }else if(backType == CallbackTimeout){
                
            }else{
                
            }
        }
    }];
}

-(void)hiddenLoadingView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:AnimateDuration];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView: loadingView cache:YES];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(startupAnimationDone:finished:context:)];
    loadingView.alpha = 0.f;
    [UIView commitAnimations];
}

- (void)startupAnimationDone:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    [loadingView removeFromSuperview];
}
@end
