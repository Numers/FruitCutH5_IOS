//
//  WQPlaySound.m
//  ylmm
//
//  Created by macmini on 14-6-26.
//  Copyright (c) 2014年 YiLiao. All rights reserved.
//

#import "WQPlaySound.h"
@implementation WQPlaySound
-(id)initForPlayingVibrate
{
    self = [super init];
    if (self) {
        soundID = kSystemSoundID_Vibrate;
    }
    return self;
}

-(id)initForPlayingSystemSoundEffectWith:(NSString *)resourceName ofType:(NSString *)type
{
    self = [super init];
    if (self) {
        NSString *path = [[NSBundle bundleWithIdentifier:@"com.apple.UIKit"] pathForResource:resourceName ofType:type];
        if (path) {
            SystemSoundID theSoundID;
            OSStatus error =  AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &theSoundID);
            if (error == kAudioServicesNoError) {
                soundID = theSoundID;
            }else {
                NSLog(@"Failed to create sound ");
            }
        }
        
    }
    return self;
}

-(id)initForPlayingSoundEffectWith:(NSString *)filename
{
    self = [super init];
    if (self) {
        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
        if (fileURL != nil)
        {
            SystemSoundID theSoundID;
            OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL, &theSoundID);
            if (error == kAudioServicesNoError){
                soundID = theSoundID;
            }else {
                NSLog(@"Failed to create sound ");
            }
        }
    }
    return self;
}

-(id)initForPlayingSoundWith:(SystemSoundID)soundId
{
    self = [super init];
    if (self) {
        soundID = soundId;
    }
    return self;
}

-(void)play
{
    AudioServicesPlaySystemSound(soundID);
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, &playFinished, (__bridge void *)(self));
}

-(void)playCirculation
{
    AudioServicesPlaySystemSound(soundID);
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, &playCirculationFinished, (__bridge void *)(self));
}

void playFinished(SystemSoundID  ssID, void* clientData)
{
//    unsigned long ID = ssID; // ssID 不能直接作为参数打印出来，需要中转一次
    // 移除完成后执行的函数
    AudioServicesRemoveSystemSoundCompletion(ssID);
    
    // 根据ID释放自定义系统声音
    AudioServicesDisposeSystemSoundID(ssID);
}

void playCirculationFinished(SystemSoundID  ssID, void* clientData)
{
    //    unsigned long ID = ssID; // ssID 不能直接作为参数打印出来，需要中转一次
    WQPlaySound *playAudio = [[WQPlaySound alloc] initForPlayingSoundWith:ssID];
    [playAudio playCirculation];
}

-(void)finishAudio
{
    // 移除完成后执行的函数
    AudioServicesRemoveSystemSoundCompletion(soundID);
    
    // 根据ID释放自定义系统声音
    AudioServicesDisposeSystemSoundID(soundID);
}

-(void)dealloc
{
    //    AudioServicesDisposeSystemSoundID(soundID);
}
@end
