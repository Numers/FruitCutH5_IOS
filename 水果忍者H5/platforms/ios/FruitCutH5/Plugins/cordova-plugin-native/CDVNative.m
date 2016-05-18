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

#import "CDVNative.h"
#import <Cordova/CDV.h>
#import "PlayAudioManager.h"
#import "BluetoothSendManager.h"

@implementation CDVNative
-(void)play:(CDVInvokedUrlCommand*)command
{
    currentCallBackId = command.callbackId;
    NSDictionary *dic = [self objectFromJsonString:[command argumentAtIndex:0]];
    if (dic) {
        NSString *fileName = [dic objectForKey:@"file"];
        if (fileName) {
            if ([fileName isEqualToString:@"menu"] || [fileName isEqualToString:@"start2"]) {
                [[PlayAudioManager defaultManager] playBackgroundAudio:[NSString stringWithFormat:@"%@.mp3",fileName]];
            }else{
                [[PlayAudioManager defaultManager] playAudio:[NSString stringWithFormat:@"%@.mp3",fileName]];
            }
            [self successWithCallbackID:currentCallBackId withMessage:@"播放成功"];
        }else{
            [self failWithCallbackID:currentCallBackId withMessage:@"Json字符串Key-value键值对有问题!"];
        }
    }

}

-(void)stop:(CDVInvokedUrlCommand*)command
{
    currentCallBackId = command.callbackId;
    [[PlayAudioManager defaultManager] stopPlayAudio];
    [self successWithCallbackID:currentCallBackId withMessage:@"播放停止"];
}

-(void)splitFruit:(CDVInvokedUrlCommand*)command
{
    currentCallBackId = command.callbackId;
    NSDictionary *dic = [self objectFromJsonString:[command argumentAtIndex:0]];
    if (dic) {
        NSString *fileName = [dic objectForKey:@"file"];
        if (fileName) {
            [[PlayAudioManager defaultManager] playAudio:[NSString stringWithFormat:@"%@.mp3",fileName]];
            [self successWithCallbackID:currentCallBackId withMessage:@"播放成功"];
        }else{
            [self failWithCallbackID:currentCallBackId withMessage:@"Json字符串Key-value键值对有问题!"];
        }
        
        NSString *type = [dic objectForKey:@"type"];
        if (type) {
            [[BluetoothSendManager defaultManager] writeCommand:[type intValue]];
        }
    }
}

-(id)objectFromJsonString:(NSString *)jsonString
{
    if (!jsonString)
    {
        [self failWithCallbackID:currentCallBackId withMessage:@"参数格式错误"];
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id params = [NSJSONSerialization JSONObjectWithData:jsonData
                                                options:NSJSONReadingMutableContainers
                                                  error:&err];
    
    if (err)
    {
        [self failWithCallbackID:currentCallBackId withMessage:@"参数格式错误"];
        return nil;
    }
    return params;
}

- (void)successWithCallbackID:(NSString *)callbackID withMessage:(NSString *)message
{
    CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:message];
    [commandResult setKeepCallback:[NSNumber numberWithInteger:1]];
    [self.commandDelegate sendPluginResult:commandResult callbackId:callbackID];
}

- (void)failWithCallbackID:(NSString *)callbackID withMessage:(NSString *)message
{
    CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:message];
    [commandResult setKeepCallback:[NSNumber numberWithInteger:1]];
    [self.commandDelegate sendPluginResult:commandResult callbackId:callbackID];
}
@end
