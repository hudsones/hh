//
//  XMGTopic.m
//  01-百思不得姐
//
//  Created by apple on 16/2/3.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGTopic.h"

@implementation XMGTopic


+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2"
             };
}
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


-(CGFloat)cellHeight{
    if (!_cellHeight) {
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4*XMGTopicCellMargin, MAXFLOAT);
        
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]} context:nil].size.height;
        
        _cellHeight = XMGTopicCellTextY + textH + XMGTopicCellMargin;
        
        if (self.type == XMGTopicTypePicture) {
            CGFloat pictureW = maxSize.width;
            CGFloat pictureH = pictureW *self.height /self.width;
            
            if (pictureH >=XMGTopicCellPictureMaxH) {
                pictureH = XMGTopicCellPictureBreakH;
                self.bigPicture = YES;
            }
            CGFloat pictureX = XMGTopicCellMargin;
            CGFloat pictureY = XMGTopicCellTextY + textH + XMGTopicCellMargin;
            _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            _cellHeight += pictureH + XMGTopicCellMargin;
        }else if (self.type == XMGTopicTypeVideo){
            
        }
        _cellHeight += XMGTopicCellBottomBarH + XMGTopicCellMargin;
    }
    return _cellHeight;
}
@end
