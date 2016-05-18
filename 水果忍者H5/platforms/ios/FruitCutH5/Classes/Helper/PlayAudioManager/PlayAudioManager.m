//
//  PlayAudioManager.m
//  FruitCutH5
//
//  Created by baolicheng on 16/5/13.
//  Copyright © 2016年 RenRenFenQi. All rights reserved.
//

#import "PlayAudioManager.h"
#import "WQPlaySound.h"
static PlayAudioManager *playAudioManager;
@implementation PlayAudioManager
+(id)defaultManager
{
    if (playAudioManager == nil) {
        playAudioManager = [[PlayAudioManager alloc] init];
    }
    return playAudioManager;
}

-(void)playAudio:(NSString *)file
{
//    [self stopPlayAudio];
    playSound = [[WQPlaySound alloc] initForPlayingSoundEffectWith:file];
    [playSound play];
}

-(void)playBackgroundAudio:(NSString *)file
{
    [self stopBackgroundAudio];
    circlePlayBackgroundSound = [[WQPlaySound alloc] initForPlayingSoundEffectWith:file];
    [circlePlayBackgroundSound playCirculation];
}

-(void)stopBackgroundAudio
{
    if (circlePlayBackgroundSound) {
        [circlePlayBackgroundSound finishAudio];
        circlePlayBackgroundSound = nil;
    }
}

-(void)stopPlayAudio
{
    if (playSound) {
        [playSound finishAudio];
        playSound = nil;
    }
}
@end
