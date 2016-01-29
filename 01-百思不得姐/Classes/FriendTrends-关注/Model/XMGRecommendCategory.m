//
//  XMGRecommendCategory.m
//  01-百思不得姐
//
//  Created by apple on 16/1/29.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGRecommendCategory.h"

@implementation XMGRecommendCategory

-(NSMutableArray *)users{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}

@end
