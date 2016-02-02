//
//  XMGPushGuideView.m
//  01-百思不得姐
//
//  Created by apple on 16/2/2.
//  Copyright (c) 2016年 小码哥. All rights reserved.
//

#import "XMGPushGuideView.h"

@implementation XMGPushGuideView

+(instancetype)PushView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}
+(void)show{
    NSString *key = @"CFBundleShortVersionString";
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults]stringForKey:key];
    if (![currentVersion isEqual:sanboxVersion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        XMGPushGuideView *guideView = [XMGPushGuideView PushView];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        
        [[NSUserDefaults standardUserDefaults]setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}
- (IBAction)close {
    [self removeFromSuperview];
}

@end
