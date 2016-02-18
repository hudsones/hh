//
//  XMGTopic.h
//  01-百思不得姐
//
//  Created by apple on 16/2/3.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMGTopic : NSObject
/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 发帖时间 */
@property (nonatomic, copy) NSString *create_time;
/** 文字内容 */
@property (nonatomic, copy) NSString *text;
/** 顶的数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩的数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发的数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论的数量 */
@property (nonatomic, assign) NSInteger comment;
@property (nonatomic, assign) CGFloat width;
/** 图片的高度 */
@property (nonatomic, assign) CGFloat height;
/** 小图片的URL */
@property (nonatomic, copy) NSString *small_image;
/** 中图片的URL */
@property (nonatomic, copy) NSString *middle_image;
/** 大图片的URL */
@property (nonatomic, copy) NSString *large_image;

/*cell的高度*/
@property (nonatomic, assign) CGFloat cellHeight;

/* 帖子的类型*/
@property (nonatomic, assign) XMGTopicType type;

/** 图片控件的frame */
@property (nonatomic, assign, readonly) CGRect pictureF;

/* 图片是否太大*/
@property (nonatomic, assign,getter=isBigPicture) BOOL bigPicture;

/** 图片的下载进度 */
@property (nonatomic, assign) CGFloat pictureProgress;
@end
