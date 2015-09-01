//
//  CheckCodeViewController.m
//  GeniusWatch
//
//  Created by 陈磊 on 15/8/23.
//  Copyright (c) 2015年 chenlei. All rights reserved.
//

#import "CheckCodeViewController.h"
#import "SetPassWordViewController.h"

#define TIP_STRING          @"验证码已发送至手机号:\n"
#define TIPLABEL_SPAXCE_Y   NAVBAR_HEIGHT + 15.0
#define TIPLABEL_HEIGHT     40.0
#define ADD_Y               15.0
#define SPACE_X             20.0 * CURRENT_SCALE
#define TEXTFIELD_HEIGHT    35.0
#define BUTTON_HEIGHT       40.0
#define CODE_BUTTON_WIDTH   80.0

@interface CheckCodeViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *codeTextField;

@end

@implementation CheckCodeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackItem];
    self.title = @"获取验证码";
    [self addBackItem];
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)initUI
{
    [self addTipLabel];
    [self addTextField];
    [self addButtons];
}

- (void)addTipLabel
{
    UILabel *tipLabel = [CreateViewTool createLabelWithFrame:CGRectMake(0, TIPLABEL_SPAXCE_Y, self.view.frame.size.width, TIPLABEL_HEIGHT) textString:[TIP_STRING stringByAppendingString:self.phoneNumberStr] textColor:[UIColor blackColor] textFont:FONT(16.0)];
    tipLabel.numberOfLines = 2;
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tipLabel];
    
    start_y = tipLabel.frame.origin.y + tipLabel.frame.size.height + ADD_Y;
}

- (void)addTextField
{
    _codeTextField = [CreateViewTool createTextFieldWithFrame:CGRectMake(SPACE_X, start_y, self.view.frame.size.width - 3 * SPACE_X - CODE_BUTTON_WIDTH, TEXTFIELD_HEIGHT) textColor:[UIColor blackColor] textFont:FONT(15.0) placeholderText:@"您的验证码"];
    //_phoneNumberTextField.borderStyle = UITextBorderStyleLine;
    [CommonTool setViewLayer:_codeTextField withLayerColor:[UIColor lightGrayColor] bordWidth:.5];
    [CommonTool clipView:_codeTextField withCornerRadius:15.0];
    _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    _codeTextField.delegate = self;
    [self.view addSubview:_codeTextField];
    
    start_y += _codeTextField.frame.size.height + ADD_Y;
}

- (void)addButtons
{
    UIButton *nextButton = [CreateViewTool createButtonWithFrame:CGRectMake(SPACE_X, start_y, self.view.frame.size.width - 2 * SPACE_X, BUTTON_HEIGHT) buttonTitle:@"下一步" titleColor:[UIColor whiteColor] normalBackgroundColor:APP_MAIN_COLOR highlightedBackgroundColor:[UIColor grayColor]
                                                    selectorName:@"nextButtonPressed:" tagDelegate:self];
    [CommonTool setViewLayer:nextButton withLayerColor:[UIColor lightGrayColor] bordWidth:.5];
    [CommonTool clipView:nextButton withCornerRadius:15.0];
    [self.view addSubview:nextButton];
}

- (void)nextButtonPressed:(UIButton *)sender
{
    NSString *codeStr = self.codeTextField.text;
    codeStr = (codeStr) ? codeStr : @"";
    if (codeStr.length != 6)
    {
        [CommonTool addAlertTipWithMessage:@"请输入正确的验证码"];
    }
    else
    {
        SetPassWordViewController *setPasswordViewController = [[SetPassWordViewController alloc] init];
        [self.navigationController pushViewController:setPasswordViewController animated:YES];
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
