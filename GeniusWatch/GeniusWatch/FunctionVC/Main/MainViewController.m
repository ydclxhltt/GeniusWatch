//
//  MainViewController.m
//  GeniusWatch
//
//  Created by clei on 15/8/21.
//  Copyright (c) 2015年 chenlei. All rights reserved.
//

#import "MainViewController.h"
#import "SliderViewController.h"
#import "BMapKit.h"

#define MAP_SPACE_Y     80.0 * CURRENT_SCALE
#define MAP_SPACE_X     40.0 * CURRENT_SCALE
#define MAP_HEIGHT      300.0 * CURRENT_SCALE
#define MENU_SPAXCE_Y   44.0
#define BABY_SPAXCE_Y   35.0
#define SPACE_X         15.0

@interface MainViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
{
    BMKLocationService *locationService;
    BMKGeoCodeSearch *geocodesearch;
}
@property (nonatomic, strong) BMKMapView *mapView;

@end

@implementation MainViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    [self setAboutLocationDelegate:nil];
}

#pragma mark 设置定位/地图代理
- (void)setAboutLocationDelegate:(id)delegate
{
    if (locationService)
        locationService.delegate = delegate;
    if (_mapView)
        _mapView.delegate = delegate;
}

#pragma mark 初始化UI
- (void)initUI
{
    [self addMapView];
    [self addBgImageView];
    [self addMenuButtons];
}

//添加背景
- (void)addBgImageView
{
    UIImageView *bgImageView = [CreateViewTool createImageViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) placeholderImage:[UIImage imageNamed:@"homepage_bg"]];
    [self.view addSubview:bgImageView];
}

//添加地图
- (void)addMapView
{
    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(MAP_SPACE_X, MAP_SPACE_Y, self.view.frame.size.width - 2 * MAP_SPACE_X, MAP_HEIGHT)];
    self.mapView.delegate = self;
    self.mapView.mapType = BMKMapTypeStandard;
    self.mapView.zoomLevel = 15.0;
    self.mapView.showsUserLocation = NO;
    [self.view addSubview:self.mapView];
}

//添加菜单按钮
- (void)addMenuButtons
{
    UIImage *image = [UIImage imageNamed:@"homepage_more_up"];
    float width = image.size.width/3 * CURRENT_SCALE;
    float height = image.size.height/3 * CURRENT_SCALE;
    UIButton *moreButton = [CreateViewTool createButtonWithFrame:CGRectMake(self.view.frame.size.width - SPACE_X - width, MENU_SPAXCE_Y, width, height) buttonImage:@"homepage_more" selectorName:@"moreButtonPressed:" tagDelegate:self];
    [self.view addSubview:moreButton];
    
    
    UIImage *babyImage = [UIImage imageNamed:@"baby_head_up"];
    float babyWidth = babyImage.size.width/3 * CURRENT_SCALE;
    float babyHeight = babyImage.size.height/3 * CURRENT_SCALE;
    
    UIImageView *babyView = [CreateViewTool createImageViewWithFrame:CGRectMake(SPACE_X, BABY_SPAXCE_Y, babyWidth, babyHeight) placeholderImage:nil];
    [self.view addSubview:babyView];
    
    UIButton *babyButton = [CreateViewTool  createButtonWithFrame:CGRectMake(0, 0, babyWidth, babyHeight) buttonImage:@"baby_head" selectorName:@"babyButtonPressed:" tagDelegate:self];
    [CommonTool setViewLayer:babyButton withLayerColor:[UIColor whiteColor] bordWidth:1.0];
    [CommonTool clipView:babyButton withCornerRadius:babyWidth/2];
    [babyView addSubview:babyButton];
    
    UIImage *cellImage = [UIImage imageNamed:@"homepage_cell"];
    float cellWidth = cellImage.size.width/3 * CURRENT_SCALE;
    float cellHeight = cellImage.size.height/3 * CURRENT_SCALE;
    UIImageView *cellImageView = [CreateViewTool createImageViewWithFrame:CGRectMake(babyButton.frame.size.width - cellWidth, babyButton.frame.size.height - cellHeight, cellWidth, cellHeight) placeholderImage:cellImage];
    [babyView addSubview:cellImageView];
}


#pragma mark 点击头像按钮
- (void)babyButtonPressed:(UIButton *)sender
{
    [[SliderViewController sharedSliderController] showLeftViewController];
}

#pragma mark 点击更多按钮
- (void)moreButtonPressed:(UIButton *)sender
{
    [[SliderViewController sharedSliderController] showRightViewController];
}


#pragma mark 开始获取地址
- (void)getCurrentAddress
{
    [self setLocation];
    [self startLocation];
}

#pragma mark  定位相关
- (void)setLocation
{
    locationService = [[BMKLocationService alloc]init];
    //定位的最小更新距离
    [BMKLocationService setLocationDistanceFilter:kCLDistanceFilterNone];
    //定位精确度
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyBest];
}

- (void)startLocation
{
    locationService.delegate = self;
    [locationService startUserLocationService];
}


- (void)stopLocation
{
    locationService.delegate = nil;
    [locationService stopUserLocationService];
    
}


#pragma mark 坐标转换地址Delegate
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    NSLog(@"result====%@",[[result addressDetail] city]);
}

#pragma mark 编译地址
- (void)getReverseGeocodeWithLocation:(CLLocationCoordinate2D)locaotion
{
    if (!geocodesearch)
    {
        geocodesearch = [[BMKGeoCodeSearch alloc] init];
        geocodesearch.delegate = self;
    }
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = locaotion;
    BOOL flag = [geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
}

#pragma mark locationManageDelegate

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"userLocation====%@",[userLocation.location description]);
    [self getReverseGeocodeWithLocation:userLocation.location.coordinate];
    [self stopLocation];
}

/**
 *定位失败后，会调用此函数
 *@param error 错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    
}

- (void)setLocationCoordinate:(CLLocationCoordinate2D)coordinate  locationText:(NSString *)location
{
    [self.mapView removeAnnotations:self.mapView.annotations];
    BMKPointAnnotation *point = [[BMKPointAnnotation alloc] init];
    point.coordinate = coordinate;
    point.title = location;
    [self.mapView addAnnotation:point];
    [self.mapView setCenterCoordinate:coordinate animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    if (_mapView)
    {
        _mapView = nil;
    }
    if (locationService)
    {
        [self stopLocation];
        locationService = nil;
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
