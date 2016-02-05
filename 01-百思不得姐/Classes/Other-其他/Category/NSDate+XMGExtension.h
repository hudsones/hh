//
//  NSDate+XMGExtension.h
//  01-百思不得姐
//
//  Created by apple on 16/2/4.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (XMGExtension)

-(NSDateComponents *)deltaFrom:(NSDate *)from;

/*
 是否为今年
 */
-(BOOL)isThisYear;

/*
 是否为今天
 */
-(BOOL)isToday;


/*
 是否为昨天
 */
-(BOOL)isYesterday;
@end
