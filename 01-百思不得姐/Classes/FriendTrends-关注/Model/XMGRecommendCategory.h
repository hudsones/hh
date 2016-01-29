//
//  XMGRecommendCategory.h
//  01-百思不得姐
//
//  Created by apple on 16/1/29.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGRecommendCategory : NSObject
/* */
@property (nonatomic, assign) NSInteger id;
/* 总数*/
@property (nonatomic, assign) NSInteger count;
/* 名字*/
@property (nonatomic, copy) NSString  *name;

/*这个类对于的用户数据 */
@property (nonatomic, strong) NSMutableArray  *users;



@end
