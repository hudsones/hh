//
//  XMGTopicViewController.h
//  01-百思不得姐
//
//  Created by apple on 16/2/5.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface XMGTopicViewController : UITableViewController
/** 帖子类型(交给子类去实现) */
/* */
@property (nonatomic, assign) XMGTopicType type;
@end
