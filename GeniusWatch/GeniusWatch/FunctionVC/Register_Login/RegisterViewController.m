//
//  RegisterViewController.m
//  GeniusWatch
//
//  Created by 陈磊 on 15/8/23.
//  Copyright (c) 2015年 chenlei. All rights reserved.
//

#import "RegisterViewController.h"
#import "CheckCodeViewController.h"

#define TIP_STRING          @"请先输入您的手机号码\n(注:请用家长手机号码注册账号)"
#define TIP_STRING1         @"请先输入您的手机号"
#define TIPLABEL_SPAXCE_Y   NAVBAR_HEIGHT + 15.0
#define TIPLABEL_HEIGHT     40.0
#define ADD_Y               15.0
#define SPACE_X             20.0 * CURRENT_SCALE


@interface RegisterViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *phoneNumberTextField;

@end

@implementation RegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"手机号码";
    [self addBackItem];
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)initUI
{
    [self addTipLabel];
    [self addTextField];
    [self addNextButton];
}

- (void)addTipLabel
{
    NSString *tipString = (self.pushType == PushTypeRegister)? TIP_STRING : TIP_STRING1;
    UILabel *tipLabel = [CreateViewTool createLabelWithFrame:CGRectMake(0, TIPLABEL_SPAXCE_Y, self.view.frame.size.width, TIPLABEL_HEIGHT) textString:tipString textColor:[UIColor blackColor] textFont:FONT(15.0)];
    tipLabel.numberOfLines = (self.pushType == PushTypeRegister) ? 2 : 1;
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tipLabel];
    
    start_y = tipLabel.frame.origin.y + tipLabel.frame.size.height + ADD_Y;
}

- (void)addTextField
{
    _phoneNumberTextField = [CreateViewTool createTextFieldWithFrame:CGRectMake(SPACE_X, start_y, self.view.frame.size.width - 2 * SPACE_X, TEXTFIELD_HEIGHT) textColor:[UIColor blackColor] textFont:FONT(16.0) placeholderText:@"您的手机号码"];
    //_phoneNumberTextField.borderStyle = UITextBorderStyleLine;
    [CommonTool setViewLayer:_phoneNumberTextField withLayerColor:[UIColor lightGrayColor] bordWidth:.5];
    [CommonTool clipView:_phoneNumberTextField withCornerRadius:15.0];
    _phoneNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    _phoneNumberTextField.delegate = self;
    [self.view addSubview:_phoneNumberTextField];
    
    start_y += _phoneNumberTextField.frame.size.height + ADD_Y;
}

- (void)addNextButton
{
    UIButton *nextButton = [CreateViewTool createButtonWithFrame:CGRectMake(SPACE_X, start_y, self.view.frame.size.width - 2 * SPACE_X, BUTTON_HEIGHT) buttonTitle:@"下一步" titleColor:[UIColor whiteColor] normalBackgroundColor:APP_MAIN_COLOR highlightedBackgroundColor:[UIColor grayColor]
                                                    selectorName:@"nextButtonPressed:" tagDelegate:self];
    [CommonTool setViewLayer:nextButton withLayerColor:[UIColor lightGrayColor] bordWidth:.5];
    [CommonTool clipView:nextButton withCornerRadius:15.0];
    [self.view addSubview:nextButton];
}

- (void)nextButtonPressed:(UIButton *)sender
{
    NSString *phoneNumberStr = (_phoneNumberTextField.text) ? _phoneNumberTextField.text : @"";
    if (![CommonTool isEmailOrPhoneNumber:phoneNumberStr])
    {
        [CommonTool addAlertTipWithMessage:@"请输入正确的手机号"];
    }
    else
    {
        //下一步
        CheckCodeViewController *checkViewController = [[CheckCodeViewController alloc] init];
        checkViewController.pushType = self.pushType;
        checkViewController.phoneNumberStr = phoneNumberStr;
        [self.navigationController pushViewController:checkViewController animated:YES];
        
    }
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
