//
//  XMGTopicPictureView.h
//  01-百思不得姐
//
//  Created by apple on 16/2/17.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMGTopic;

@interface XMGTopicPictureView : UIView

+(instancetype)pictureView;

/*帖子数据 */
@property (nonatomic, strong) XMGTopic  *topic;


@end
