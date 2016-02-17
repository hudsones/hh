//
//  XMGTopic.m
//  01-百思不得姐
//
//  Created by apple on 16/2/3.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGTopic.h"

@implementation XMGTopic
-(NSString *)create_time{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate *create = [fmt dateFromString:_create_time];
    
    if (create.isThisYear) {
        if (create.isToday) {
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%zd小时前",cmps.hour];
            }else if(cmps.minute >=1){
                return [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
            }else{
                return @"刚刚";
            }
        }else if(create.isYesterday){
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:create];
        }else{
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:create];
        }
    }else{
        return _create_time;
    }
}
@end
