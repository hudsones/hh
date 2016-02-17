//
//  XMGTopicCell.m
//  01-百思不得姐
//
//  Created by apple on 16/2/3.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGTopicCell.h"
#import <UIImageView+WebCache.h>
#import "XMGTopic.h"
#import "XMGTopicPictureView.h"

@interface XMGTopicCell()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;

@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;


@property (weak, nonatomic) IBOutlet UILabel *text_label;

/*图片帖子的内容 */
@property (nonatomic, weak) XMGTopicPictureView  *pictureView;
@end
@implementation XMGTopicCell

-(XMGTopicPictureView *)pictureView{
    if (!_pictureView) {
        XMGTopicPictureView *pictureView = [XMGTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (void)awakeFromNib {
    UIImageView *bgView = [[UIImageView alloc]init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}
-(void)setTopics:(XMGTopic *)topics{
    _topics = topics;
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topics.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topics.name;
    self.createTimeLabel.text = topics.create_time;
    
    [self setupButtonTitle:self.dingButton count:topics.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topics.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topics.repost placeholder:@"转发"];
    [self setupButtonTitle:self.commentButton count:topics.comment placeholder:@"评论"];
    
    self.text_label.text = topics.text;
    
    if (topics.type == XMGTopicTypePicture) {
        self.pictureView.topic = topics;
        self.pictureView.frame = topics.pictureF;
    }else if(topics.type == XMGTopicTypeVoice){
        
    }
}

-(void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder{
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万",count/10000.0];
    }else if(count > 0){
        placeholder = [NSString stringWithFormat:@"%zd",count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}
-(void)setFrame:(CGRect)frame{
    
    static CGFloat margin = 10;
    frame.origin.x = margin;
    frame.size.width -= 2 * margin;
    frame.size.height -= margin;
    frame.origin.y += margin;
    
    [super setFrame:frame];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
