//
//  XMGRecommendCategoryCell.m
//  01-百思不得姐
//
//  Created by apple on 16/1/29.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGRecommendCategoryCell.h"
#import "XMGRecommendCategory.h"


@interface XMGRecommendCategoryCell()
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;

@end

@implementation XMGRecommendCategoryCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = XMGRGBColor(244, 244, 244);
   self.selectedIndicator.backgroundColor = XMGRGBColor(219, 21, 26);
    
  }

-(void)setCategory:(XMGRecommendCategory *)category{
    _category = category;
    self.textLabel.text = category.name;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    [super setSelected:selected animated:animated];
    self.selectedIndicator.hidden = !selected;
    self.textLabel.textColor = selected ? self.selectedIndicator.backgroundColor : XMGRGBColor(78, 78, 78);
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
}



@end
