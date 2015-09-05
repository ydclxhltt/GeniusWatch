//
//  SettingViewController.m
//  GeniusWatch
//
//  Created by 陈磊 on 15/9/5.
//  Copyright (c) 2015年 chenlei. All rights reserved.
//

#import "SettingViewController.h"

#define ROW_HEIGHT      50.0
#define HEADER_HEIGHT   2.0
#define SPACE_X         5.0 * CURRENT_SCALE
#define SPACE_Y         30.0

@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *imageArray;

@end

@implementation SettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addBackItem];
    [self initUI];
    
    self.dataArray = @[@[@"消息通知",@"修改密码"],@[@"清除缓存",@"关于"]];
    self.imageArray = @[@[@"app_set_after_information",@"app_set_after_password"],@[@"app_set_after_eliminate",@"app_set_after_app"]];
    // Do any additional setup after loading the view.
}

#pragma mark 初始化UI
- (void)initUI
{
    [self addTableView];
    [self addTableViewFoot];
}

//添加表
- (void)addTableView
{
    [self addTableViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) tableType:UITableViewStylePlain tableDelegate:self];
}

- (void)addTableViewFoot
{
    UIImageView *footView = [CreateViewTool createImageViewWithFrame:CGRectMake(0, 0, self.table.frame.size.width, self.view.frame.size.height - (NAVBAR_HEIGHT + ROW_HEIGHT * 4 + HEADER_HEIGHT)) placeholderImage:nil];
    footView.backgroundColor = [UIColor whiteColor];
    
    UIButton *exitButton = [CreateViewTool createButtonWithFrame:CGRectMake(SPACE_X, SPACE_Y, footView.frame.size.width - 2 * SPACE_X, BUTTON_HEIGHT) buttonTitle:@"退出登录" titleColor:APP_MAIN_COLOR normalBackgroundColor:[UIColor clearColor] highlightedBackgroundColor:[UIColor grayColor] selectorName:@"registerButtonPressed:" tagDelegate:self];
    [CommonTool setViewLayer:exitButton withLayerColor:[UIColor lightGrayColor] bordWidth:1.0];
    [CommonTool clipView:exitButton withCornerRadius:20.0];
    [footView addSubview:exitButton];
    
    self.table.tableFooterView = footView;
}

#pragma mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (section == 0) ? 0 : HEADER_HEIGHT;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *imageView = [CreateViewTool createImageViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, (section == 0) ? 0 : HEADER_HEIGHT) placeholderImage:nil];
    imageView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4];
    return imageView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ROW_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.imageView.transform = CGAffineTransformMakeScale(.5, .5);
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    
    cell.imageView.image = [UIImage imageNamed:self.imageArray[indexPath.section][indexPath.row]];
    cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
    cell.textLabel.font = FONT(15.0);
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
