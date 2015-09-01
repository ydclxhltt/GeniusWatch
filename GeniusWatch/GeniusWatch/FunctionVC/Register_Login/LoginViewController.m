//
//  LoginViewController.m
//  GeniusWatch
//
//  Created by 陈磊 on 15/8/23.
//  Copyright (c) 2015年 chenlei. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"

#define TEXTFIELD_Y         NAVBAR_HEIGHT + 15.0
#define ADD_Y               10.0
#define SPACE_X             20.0 * CURRENT_SCALE
#define TEXTFIELD_HEIGHT    35.0
#define BUTTON_HEIGHT       40.0
#define PWD_BTN_WIDTH       80.0
#define REGISTE_BTN_SPACE   15.0

@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *usernameTextField;
@property (nonatomic, strong) UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"登录";
    
    if (self.isShowBackItem)
    {
        [self addBackItem];
        
    }
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)initUI
{
    [self addTextFields];
    [self addButtons];
}

- (void)addTextFields
{
    start_y += TEXTFIELD_Y;
    
    _usernameTextField = [CreateViewTool createTextFieldWithFrame:CGRectMake(SPACE_X, start_y, self.view.frame.size.width - 2 * SPACE_X, TEXTFIELD_HEIGHT) textColor:[UIColor blackColor] textFont:FONT(15.0) placeholderText:@"用户名"];
    //_phoneNumberTextField.borderStyle = UITextBorderStyleLine;
    _usernameTextField.keyboardType = UIKeyboardTypeNumberPad;
    [CommonTool setViewLayer:_usernameTextField withLayerColor:[UIColor lightGrayColor] bordWidth:.5];
    [CommonTool clipView:_usernameTextField withCornerRadius:15.0];
    _usernameTextField.delegate = self;
    [self.view addSubview:_usernameTextField];
    
    start_y += _usernameTextField.frame.size.height + ADD_Y;
    
    _passwordTextField = [CreateViewTool createTextFieldWithFrame:CGRectMake(SPACE_X, start_y, self.view.frame.size.width - 2 * SPACE_X, TEXTFIELD_HEIGHT) textColor:[UIColor blackColor] textFont:FONT(15.0) placeholderText:@"密码"];
    //_phoneNumberTextField.borderStyle = UITextBorderStyleLine;
    [CommonTool setViewLayer:_passwordTextField withLayerColor:[UIColor lightGrayColor] bordWidth:.5];
    [CommonTool clipView:_passwordTextField withCornerRadius:15.0];
    _passwordTextField.delegate = self;
    _passwordTextField.secureTextEntry = YES;
    [self.view addSubview:_passwordTextField];
    
    start_y += _passwordTextField.frame.size.height;
}

- (void)addButtons
{
    UIButton *getPasswordButton = [CreateViewTool createButtonWithFrame:CGRectMake(_passwordTextField.frame.size.width + _passwordTextField.frame.origin.x - PWD_BTN_WIDTH, start_y, PWD_BTN_WIDTH, BUTTON_HEIGHT) buttonTitle:@"忘记密码" titleColor:APP_MAIN_COLOR normalBackgroundColor:[UIColor clearColor] highlightedBackgroundColor:nil selectorName:@"getPasswordButtonPrssed:" tagDelegate:self];
    getPasswordButton.titleLabel.font = FONT(15.0);
    getPasswordButton.showsTouchWhenHighlighted = YES;
    [self.view addSubview:getPasswordButton];
    
    start_y += getPasswordButton.frame.size.height + ADD_Y;
    
    UIButton *loginButton = [CreateViewTool createButtonWithFrame:CGRectMake(SPACE_X, start_y, self.view.frame.size.width - 2 * SPACE_X, BUTTON_HEIGHT) buttonTitle:@"登录" titleColor:[UIColor whiteColor] normalBackgroundColor:APP_MAIN_COLOR highlightedBackgroundColor:[UIColor grayColor] selectorName:@"loginButtonPressed:" tagDelegate:self];
    [CommonTool setViewLayer:loginButton withLayerColor:[UIColor whiteColor] bordWidth:1.0];
    [CommonTool clipView:loginButton withCornerRadius:15.0];
    [self.view addSubview:loginButton];
    
    
    start_y = self.view.frame.size.height - BUTTON_HEIGHT - REGISTE_BTN_SPACE;
    
    UIButton *registerButton = [CreateViewTool createButtonWithFrame:CGRectMake((self.view.frame.size.width - PWD_BTN_WIDTH)/2, start_y, PWD_BTN_WIDTH, BUTTON_HEIGHT) buttonTitle:@"注册" titleColor:APP_MAIN_COLOR normalBackgroundColor:[UIColor clearColor] highlightedBackgroundColor:nil selectorName:@"registerButtonPrssed:" tagDelegate:self];
    registerButton.titleLabel.font = FONT(17.0);
    registerButton.showsTouchWhenHighlighted = YES;
    [self.view addSubview:registerButton];
}


- (void)loginButtonPressed:(UIButton *)sender
{
    [_passwordTextField resignFirstResponder];
    [_usernameTextField resignFirstResponder];
    
    if ([self isCanCommit])
    {
        //登录请求
        [self dismissViewControllerAnimated:YES completion:^{}];
    }
}

- (BOOL)isCanCommit
{
    NSString *username = _usernameTextField.text;
    username = (username) ? username : @"";
    NSString *password = _passwordTextField.text;
    password = (password) ? password : @"";
    
    NSString *meaasge = @"";
    
    if (![CommonTool isEmailOrPhoneNumber:username])
    {
        meaasge = @"请输入正确的手机号";
    }
    else if (password.length < 6)
    {
        meaasge = @"密码不能少于6位";
    }
    
    if (meaasge.length == 0)
    {
        return YES;
    }
    else
    {
        [CommonTool addAlertTipWithMessage:meaasge];
        return NO;
    }
}

- (void)getPasswordButtonPrssed:(UIButton *)sender
{
    RegisterViewController *registerViewController = [[RegisterViewController alloc] init];
    registerViewController.pushType = PushTypeNewPassword;
    [self.navigationController pushViewController:registerViewController animated:YES];
}



- (void)registerButtonPrssed:(UIButton *)sender
{
    RegisterViewController *registerViewController = [[RegisterViewController alloc] init];
    registerViewController.pushType = PushTypeRegister;
    [self.navigationController pushViewController:registerViewController animated:YES];
}


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
