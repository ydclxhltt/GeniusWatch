//
//  LeftViewController.m
//  GeniusWatch
//
//  Created by clei on 15/8/21.
//  Copyright (c) 2015年 chenlei. All rights reserved.
//

#import "RightViewController.h"

#define SPACE_Y       64.0
#define TITLE_HEIGHT  25.0
#define ADD_Y         15.0

@interface RightViewController ()

@end

@implementation RightViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
    // Do any additional setup after loading the view.
}

#pragma mark 初始化UI
- (void)initUI
{
    [self addButtons];
}

//添加功能按钮
- (void)addButtons
{
    NSArray *titleArray = @[@"通讯录",@"手机话费",@"消息记录",@"问题与反馈",@"APP设置"];
    NSArray *imageArray = @[@"set_linkman",@"set_charge",@"set_infomation",@"set_feedback",@"set_set"];
    UIImage *image = [UIImage imageNamed:[imageArray[0] stringByAppendingString:@"_up"]];
    float buttonHeight = image.size.height/3 * CURRENT_SCALE;
    float buttonWidth = image.size.width/3 * CURRENT_SCALE;
    for (int i = 0; i < [titleArray count]; i++)
    {
        UIButton *button = [CreateViewTool createButtonWithFrame:CGRectMake(self.view.frame.size.width - RIGHTContentOffset +(RIGHTContentOffset - buttonWidth)/2, SPACE_Y + i * (buttonHeight + TITLE_HEIGHT + ADD_Y), buttonWidth, buttonHeight) buttonImage:imageArray[i] selectorName:@"buttonPressed:" tagDelegate:self];
        [self.view addSubview:button];
        
        UILabel *label = [CreateViewTool createLabelWithFrame:CGRectMake(self.view.frame.size.width - RIGHTContentOffset, button.frame.size.height + button.frame.origin.y, RIGHTContentOffset, TITLE_HEIGHT) textString:titleArray[i] textColor:[UIColor whiteColor] textFont:FONT(14.0)];
        label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:label];
    }
}

#pragma mark 点击功能按钮响应事件
- (void)buttonPressed:(UIButton *)sender
{
    
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
