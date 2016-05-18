//
//  BluetoothSendManager.m
//  FruitCutH5
//
//  Created by baolicheng on 16/5/14.
//
//

#import "BluetoothSendManager.h"
#define TimeInterval 5.0f
static BluetoothSendManager *bluetoothSendManager;
@implementation BluetoothSendManager
+(id)defaultManager
{
    if (bluetoothSendManager == nil) {
        bluetoothSendManager = [[BluetoothSendManager alloc] init];
    }
    return bluetoothSendManager;
}

-(void)writeCommand:(BluetoothCommand)command
{
    if ([[BluetoothMacManager defaultManager] isConnected]) {
        [[BluetoothMacManager defaultManager] writeCharacteristicWithCommand:command];
        
        if (timer) {
            if ([timer isValid]) {
                [timer invalidate];
                timer = nil;
            }
        }
        
        NSTimeInterval nextDateInterval = [[NSDate date] timeIntervalSince1970] + TimeInterval;
        NSDate *nextDate = [NSDate dateWithTimeIntervalSince1970:nextDateInterval];
        timer = [[NSTimer alloc] initWithFireDate:nextDate interval:TimeInterval target:self selector:@selector(sendCloseCommand) userInfo:nil repeats:NO];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    }
}

-(void)sendCloseCommand
{
    if ([[BluetoothMacManager defaultManager] isConnected]) {
        [[BluetoothMacManager defaultManager] writeCharacteristicWithCommand:CommandSmellClose];
    }
}
@end
