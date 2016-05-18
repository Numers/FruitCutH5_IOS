//
//  BluetoothSendManager.h
//  FruitCutH5
//
//  Created by baolicheng on 16/5/14.
//
//

#import <Foundation/Foundation.h>
#import "BluetoothMacManager.h"

@interface BluetoothSendManager : NSObject
{
    NSTimer *timer;
}

+(id)defaultManager;
-(void)writeCommand:(BluetoothCommand)command;
@end
