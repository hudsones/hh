//
//  XMGTextfieldAttr.m
//  01-百思不得姐
//
//  Created by apple on 16/2/1.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGTextfieldAttr.h"
#import <objc/runtime.h>
@implementation XMGTextfieldAttr

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//-(void)drawPlaceholderInRect:(CGRect)rect{
//    [self.placeholder drawInRect:CGRectMake(0, 15, rect.size.width, 25) withAttributes:@{
//                                                                                         NSForegroundColorAttributeName:[UIColor whiteColor],
//                                                                                         NSFontAttributeName:self.font}];
//}
//runtime的运行机制
//+(void)initialize{
//    unsigned int count = 0;
//    
//    Ivar *ivars = class_copyIvarList([UITextField class], &count);
//    
//    for (int i=0; i<count; i++) {
//        Ivar ivar = *(ivars+i);
//        XMGLog(@"%s",ivar_getName(ivar));
//    }
//}
-(void)awakeFromNib{
    [self setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.tintColor = self.textColor;
}
-(BOOL)becomeFirstResponder{
    [self setValue:self.textColor forKeyPath:@"_placeholderLabel.textColor"];
    return [super becomeFirstResponder];
}
-(BOOL)resignFirstResponder{
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    return [super resignFirstResponder];
}
@end
