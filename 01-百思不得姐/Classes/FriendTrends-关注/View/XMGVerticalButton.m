//
//  XMGVerticalButton.m
//  01-百思不得姐
//
//  Created by apple on 16/2/1.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGVerticalButton.h"

@implementation XMGVerticalButton

-(void)setup{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
-(void)awakeFromNib{
    [self setup];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    
    
    self.titleLabel.x = 5;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
    
    
}

@end
