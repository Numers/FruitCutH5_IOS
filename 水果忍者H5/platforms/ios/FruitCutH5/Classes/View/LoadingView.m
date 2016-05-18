//
//  LoadingView.m
//  FruitCutH5
//
//  Created by baolicheng on 16/5/14.
//
//

#import "LoadingView.h"

@implementation LoadingView
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        lblLoading = [[UILabel alloc] init];
        [lblLoading setText:@"Loading..."];
        [lblLoading setTextColor:[UIColor blackColor]];
        [lblLoading setFont:[UIFont systemFontOfSize:18.0f]];
        [lblLoading sizeToFit];
        [lblLoading setCenter:CGPointMake(frame.size.width / 2, frame.size.height / 2)];
        [self addSubview:lblLoading];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
