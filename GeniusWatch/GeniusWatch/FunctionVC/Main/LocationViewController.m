//
//  LocationViewController.m
//  GeniusWatch
//
//  Created by clei on 15/9/6.
//  Copyright (c) 2015年 chenlei. All rights reserved.
//

#define BAR_SPACE_X     100.0
#define BAR_SPACE_Y     30.0
#define SPACE_Y         150.0 * CURRENT_SCALE
#define SPACE_X         20.0

#import "LocationViewController.h"
#import "BMapKit.h"

@interface LocationViewController ()<BMKMapViewDelegate>

@property (nonatomic, retain) BMKMapView *mapView;

@end

@implementation LocationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"定位";
    [self addBackItem];
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self setAboutLocationDelegate:self];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self setAboutLocationDelegate:nil];
}

#pragma mark 设置定位/地图代理
- (void)setAboutLocationDelegate:(id)delegate
{
    if (_mapView)
        _mapView.delegate = delegate;
}


#pragma mark 初始化UI
- (void)initUI
{
    [self addMapView];
    [self addTypeButton];
}

//添加地图
- (void)addMapView
{
    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.mapView.delegate = self;
    self.mapView.mapType = BMKMapTypeStandard;
    self.mapView.zoomLevel = 15.0;
    self.mapView.showsUserLocation = NO;
    self.mapView.showMapScaleBar = YES;
    self.mapView.mapScaleBarPosition = CGPointMake(self.mapView.frame.size.width - BAR_SPACE_X, self.mapView.frame.size.height - BAR_SPACE_Y);
    [self.view addSubview:self.mapView];
}

//添加模式切换按钮
- (void)addTypeButton
{
    UIImage *image = [UIImage imageNamed:@"location_map_model_up"];
    float width = image.size.width/3 * CURRENT_SCALE;
    float height = image.size.height/3 * CURRENT_SCALE;
    UIButton *typeButton = [CreateViewTool createButtonWithFrame:CGRectMake(self.view.frame.size.width - SPACE_X - width, SPACE_Y, width, height) buttonImage:@"location_map_model" selectorName:@"typeButtonPressed:" tagDelegate:self];
    [typeButton setBackgroundImage:nil forState:UIControlStateHighlighted];
    [self.view addSubview:typeButton];
}


#pragma mark 切换地图模型按钮响应事件
- (void)typeButtonPressed:(UIButton *)sender
{
    sender.selected = !sender.selected;
    self.mapView.mapType = (!sender.selected) ? BMKMapTypeStandard : BMKMapTypeSatellite;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    if (self.mapView)
    {
        self.mapView = nil;
    }
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
