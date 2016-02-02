//
//  XMGLoginRegisterViewController.m
//  01-百思不得姐
//
//  Created by apple on 16/2/1.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGLoginRegisterViewController.h"

@interface XMGLoginRegisterViewController ()
//@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
//@property (weak, nonatomic) IBOutlet UITextField *iphoneTextfile;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginView;


@end

@implementation XMGLoginRegisterViewController
- (IBAction)login:(id)sender {
    if (self.loginView.constant == 0) {
        self.loginView.constant = -self.view.size.width;
    }else{
        self.loginView.constant = 0;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.loginBtn.layer.cornerRadius = 20;
//    self.loginBtn.layer.masksToBounds = YES;
    //UITextField
//    
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    
//    NSAttributedString *place = [[NSAttributedString alloc]initWithString:@"手机号:" attributes:dict];
//    self.iphoneTextfile.attributedPlaceholder =place;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
