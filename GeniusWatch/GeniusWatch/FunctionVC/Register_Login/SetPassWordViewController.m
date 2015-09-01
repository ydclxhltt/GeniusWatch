//
//  SetPassWordViewController.m
//  GeniusWatch
//
//  Created by 陈磊 on 15/8/23.
//  Copyright (c) 2015年 chenlei. All rights reserved.
//

#import "SetPassWordViewController.h"
#import "LoginViewController.h"

#define TEXTFIELD_Y         NAVBAR_HEIGHT + 15.0
#define ADD_Y               10.0
#define SPACE_X             20.0 * CURRENT_SCALE



@interface SetPassWordViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *pwdTextField1;
@property (nonatomic, strong) UITextField *pwdTextField2;

@end

@implementation SetPassWordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"设置密码";
    [self addBackItem];
    [self initUI];
    // Do any additional setup after loading the view.
}

#pragma mark 初始化UI
- (void)initUI
{
    [self addTextFields];
    [self addSureButton];
}

//添加输入框
- (void)addTextFields
{
    start_y = TEXTFIELD_Y;
    _pwdTextField1 = [CreateViewTool createTextFieldWithFrame:CGRectMake(SPACE_X, start_y, self.view.frame.size.width - 2 * SPACE_X, TEXTFIELD_HEIGHT) textColor:[UIColor blackColor] textFont:FONT(15.0) placeholderText:@"密码"];
    [CommonTool setViewLayer:_pwdTextField1 withLayerColor:[UIColor lightGrayColor] bordWidth:.5];
    [CommonTool clipView:_pwdTextField1 withCornerRadius:15.0];
    _pwdTextField1.secureTextEntry = YES;
    _pwdTextField1.delegate = self;
    [self.view addSubview:_pwdTextField1];
    
    start_y += _pwdTextField1.frame.size.height + ADD_Y;
    
    _pwdTextField2 = [CreateViewTool createTextFieldWithFrame:CGRectMake(SPACE_X, start_y, self.view.frame.size.width - 2 * SPACE_X, TEXTFIELD_HEIGHT) textColor:[UIColor blackColor] textFont:FONT(15.0) placeholderText:@"确认密码"];
    [CommonTool setViewLayer:_pwdTextField2 withLayerColor:[UIColor lightGrayColor] bordWidth:.5];
    [CommonTool clipView:_pwdTextField2 withCornerRadius:15.0];
    _pwdTextField2.secureTextEntry = YES;
    _pwdTextField2.delegate = self;
    [self.view addSubview:_pwdTextField2];
    
    start_y += _pwdTextField2.frame.size.height + 2 * ADD_Y;
}

//添加提交按钮
- (void)addSureButton
{
    UIButton *sureButton = [CreateViewTool createButtonWithFrame:CGRectMake(SPACE_X, start_y, self.view.frame.size.width - 2 * SPACE_X, BUTTON_HEIGHT) buttonTitle:@"确定" titleColor:[UIColor whiteColor] normalBackgroundColor:APP_MAIN_COLOR highlightedBackgroundColor:[UIColor grayColor] selectorName:@"sureButtonPressed:" tagDelegate:self];
    [CommonTool setViewLayer:sureButton withLayerColor:[UIColor whiteColor] bordWidth:1.0];
    [CommonTool clipView:sureButton withCornerRadius:15.0];
    [self.view addSubview:sureButton];
    
}

#pragma mark 提交按钮点击
- (void)sureButtonPressed:(UIButton *)sender
{
    if (![self isCanCommit])
    {
        return;
    }
    else
    {
        //设置密码
        //[self dismissViewControllerAnimated:YES completion:^{}];
        NSArray *array = self.navigationController.viewControllers;
        UIViewController *viewController = ([array[1] isKindOfClass:[LoginViewController class]]) ? array[1] : array[0];
        [self.navigationController popToViewController:viewController animated:YES];
    }
}

//验证是否合法
- (BOOL)isCanCommit
{
    NSString *passwordStr1 = _pwdTextField1.text;
    passwordStr1 = (passwordStr1) ? passwordStr1 : @"";
    NSString *passwordStr2 = _pwdTextField2.text;
    passwordStr2 = (passwordStr2) ? passwordStr2 : @"";
    NSString *message = @"";
    
    if (passwordStr1.length < 6 || passwordStr2.length < 6)
    {
        message = @"密码不能小于6位";
    }
    else if(![passwordStr1 isEqualToString:passwordStr2])
    {
        message = @"密码不一致";
    }
    
    if (message.length != 0)
    {
        [CommonTool addAlertTipWithMessage:message];
        return NO;
    }
    
    return YES;
}

#pragma mark  UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
