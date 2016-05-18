//
//  PlayAudioManager.h
//  FruitCutH5
//
//  Created by baolicheng on 16/5/13.
//  Copyright © 2016年 RenRenFenQi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WQPlaySound;
@interface PlayAudioManager : NSObject
{
    WQPlaySound *playSound;
    WQPlaySound *circlePlayBackgroundSound;
}
+(id)defaultManager;

-(void)playAudio:(NSString *)file;

-(void)playBackgroundAudio:(NSString *)file;

-(void)stopPlayAudio;
@end
