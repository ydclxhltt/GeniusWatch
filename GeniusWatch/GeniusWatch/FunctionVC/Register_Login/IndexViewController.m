//
//  IndexViewController.m
//  GeniusWatch
//
//  Created by 陈磊 on 15/8/22.
//  Copyright (c) 2015年 chenlei. All rights reserved.
//

#import "IndexViewController.h"
#import "RegisterViewController.h"
#import "LoginViewController.h"

#define BUTTON_SPACE_X 30.0 * CURRENT_SCALE
#define BUTTON_SPACE_Y 30.0
#define BUTTON_HEIGHT  40.0

@interface IndexViewController ()

@end

@implementation IndexViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBar.hidden = NO;
}


- (void)initUI
{
    [self addBgImageView];
    [self addButtons];
}

- (void)addBgImageView
{
    UIImageView *imageView = [CreateViewTool createImageViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) placeholderImage:[UIImage imageNamed:@"register_bg"]];
    [self.view addSubview:imageView];
}

- (void)addButtons
{
    float buttonWidth = (self.view.frame.size.width - 3 * BUTTON_SPACE_X)/2;
    float buttonY = self.view.frame.size.height - BUTTON_HEIGHT - BUTTON_SPACE_Y;
    
    UIButton *registerButton = [CreateViewTool createButtonWithFrame:CGRectMake(BUTTON_SPACE_X, buttonY, buttonWidth, BUTTON_HEIGHT) buttonTitle:@"注册" titleColor:[UIColor whiteColor] normalBackgroundColor:[UIColor clearColor] highlightedBackgroundColor:[UIColor grayColor] selectorName:@"registerButtonPressed:" tagDelegate:self];
    [CommonTool setViewLayer:registerButton withLayerColor:[UIColor whiteColor] bordWidth:1.0];
    [CommonTool clipView:registerButton withCornerRadius:20.0];
    [self.view addSubview:registerButton];
    
    UIButton *loginButton = [CreateViewTool createButtonWithFrame:CGRectMake(BUTTON_SPACE_X + registerButton.frame.size.width + registerButton.frame.origin.x, buttonY, buttonWidth, BUTTON_HEIGHT) buttonTitle:@"登录" titleColor:[UIColor whiteColor] normalBackgroundColor:[UIColor clearColor] highlightedBackgroundColor:[UIColor grayColor] selectorName:@"loginButtonPressed:" tagDelegate:self];
    [CommonTool setViewLayer:loginButton withLayerColor:[UIColor whiteColor] bordWidth:1.0];
    [CommonTool clipView:loginButton withCornerRadius:20.0];
    [self.view addSubview:loginButton];
}


- (void)registerButtonPressed:(UIButton *)sender
{
    RegisterViewController *registerViewController = [[RegisterViewController alloc] init];
    registerViewController.pushType = PushTypeRegister;
    [self.navigationController pushViewController:registerViewController animated:YES];
}

- (void)loginButtonPressed:(UIButton *)sender
{
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    loginViewController.isShowBackItem = YES;
    [self.navigationController pushViewController:loginViewController animated:YES];
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
