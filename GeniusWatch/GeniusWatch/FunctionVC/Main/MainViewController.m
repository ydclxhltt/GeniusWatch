//
//  MainViewController.m
//  GeniusWatch
//
//  Created by clei on 15/8/21.
//  Copyright (c) 2015年 chenlei. All rights reserved.
//

#import "MainViewController.h"
//#import "SliderViewController.h"
#import "MainSideViewController.h"
#import "BMapKit.h"

//地图
#define MAP_SPACE_Y         80.0 * CURRENT_SCALE
#define MAP_SPACE_X         40.0 * CURRENT_SCALE
#define MAP_HEIGHT          300.0 * CURRENT_SCALE
//左右按钮
#define MENU_SPAXCE_Y       44.0
#define BABY_SPAXCE_Y       35.0
#define BABY_SPACE_X        20.0
#define MENU_SPACE_X        10.0
#define BABY_LAYER_COLOR    RGB(86.0,151.0,142.0)

//守护按钮
//#define ADD_Y           5.0 * CURRENT_SCALE

@interface MainViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
{
    BMKLocationService *locationService;
    BMKGeoCodeSearch *geocodesearch;
}
//@property (nonatomic, strong) UIButton *savePeaceButton;
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
    [self addFunctionButtons];
}

//添加背景
- (void)addBgImageView
{
//    UIImageView *bgImageView = [CreateViewTool createImageViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) placeholderImage:[UIImage imageNamed:@"homepage_bg"]];
//    [self.view addSubview:bgImageView];
    NSArray *imageArray = @[@"top",@"middle",@"bottom"];
    float y = 0.0;
    for (int i = 0; i < [imageArray count]; i++)
    {
        UIImage *image = [UIImage imageNamed:imageArray[i]];
        float width = image.size.width/3 * CURRENT_SCALE;
        float height = image.size.height/3 * CURRENT_SCALE;
        UIImageView *imageView = [CreateViewTool createImageViewWithFrame:CGRectMake(0, y, width, height) placeholderImage:image];
        [self.view addSubview:imageView];
         y += height;
    }
}

//添加地图
- (void)addMapView
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                   ^{
                       self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(MAP_SPACE_X, MAP_SPACE_Y, self.view.frame.size.width - 2 * MAP_SPACE_X, MAP_HEIGHT)];
                       self.mapView.delegate = self;
                       self.mapView.mapType = BMKMapTypeStandard;
                       self.mapView.zoomLevel = 15.0;
                       self.mapView.showsUserLocation = NO;
                       dispatch_sync(dispatch_get_main_queue(), ^
                       {
                           [self.view insertSubview:self.mapView atIndex:0];

                       });
                    });
    
}

//添加菜单按钮
- (void)addMenuButtons
{
    UIImage *image = [UIImage imageNamed:@"homepage_more_up"];
    float width = image.size.width/3 * CURRENT_SCALE;
    float height = image.size.height/3 * CURRENT_SCALE;
    UIButton *moreButton = [CreateViewTool createButtonWithFrame:CGRectMake(self.view.frame.size.width - MENU_SPACE_X - width, MENU_SPAXCE_Y, width, height) buttonImage:@"homepage_more" selectorName:@"moreButtonPressed:" tagDelegate:self];
    [self.view addSubview:moreButton];
    
    
    UIImage *babyImage = [UIImage imageNamed:@"baby_head_up"];
    float babyWidth = babyImage.size.width/3 * CURRENT_SCALE;
    float babyHeight = babyImage.size.height/3 * CURRENT_SCALE;
    
    UIImageView *babyView = [CreateViewTool createImageViewWithFrame:CGRectMake(BABY_SPACE_X, BABY_SPAXCE_Y, babyWidth, babyHeight) placeholderImage:nil];
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

/*
 *******************屏蔽小天才UI效果***************
- (void)addFunctionButtons
{
    float savePeaceButton_y = self.mapView.frame.origin.y + self.mapView.frame.size.height + ADD_Y;
    UIImage *savePeaceButtonImage = [UIImage imageNamed:@"homepage_school_up"];
    float savePeaceButtonImageWidth = savePeaceButtonImage.size.width/3 * CURRENT_SCALE;
    float savePeaceButtonImageHeight = savePeaceButtonImage.size.height/3 * CURRENT_SCALE;
    self.savePeaceButton = [CreateViewTool  createButtonWithFrame:CGRectMake((self.view.frame.size.width - savePeaceButtonImageWidth)/2, savePeaceButton_y , savePeaceButtonImageWidth, savePeaceButtonImageHeight) buttonImage:@"homepage_school" selectorName:@"savePeaceButtonPressed:" tagDelegate:self];
    [self.view addSubview:self.savePeaceButton];
    
    NSArray *imageArray = @[@"homepage_location",@"homepage_phone",@"homepage_chat"];
    float totleWidth = 0.0;
    float y1 = self.savePeaceButton.frame.size.height + self.savePeaceButton.frame.origin.y + FUNC_ADD_Y;
    float y2 = y1;
    for (int i = 0; i < [imageArray count]; i++)
    {
        UIImage *image = [UIImage imageNamed:[imageArray[i] stringByAppendingString:@"_up"]];
        float width = image.size.width/3 * CURRENT_SCALE;
        float height = image.size.height/3 * CURRENT_SCALE;
        if (i != 1)
        {
            y2 = y1 + height/3;
        }
        totleWidth += width;
    }
    float functionButtonAddX = (self.view.frame.size.width - 2 * FUNC_SPACE_X - totleWidth)/2;

    for (int i = 0; i < [imageArray count]; i++)
    {
        UIImage *image = [UIImage imageNamed:[imageArray[i] stringByAppendingString:@"_up"]];
        float width = image.size.width/3 * CURRENT_SCALE;
        float height = image.size.height/3 * CURRENT_SCALE;
        float x = FUNC_SPACE_X + i * (width + functionButtonAddX);
        float y = (i != 1) ? y2 : y1;
        UIButton *button = [CreateViewTool createButtonWithFrame:CGRectMake(x, y, width, height) buttonImage:imageArray[i] selectorName:@"" tagDelegate:self];
        button.tag = i + 1;
        [self.view addSubview:button];
    }
   
}
*******************屏蔽小天才UI效果***************
*/

//添加
- (void)addFunctionButtons
{
    NSValue *point1 = [NSValue valueWithCGRect:CGRectMake(125.0, 438.0, 123.0, 64.0)];
    NSValue *point2 = [NSValue valueWithCGRect:CGRectMake(156.0, 495.0, 61.0, 61.0)];
    NSValue *point3 = [NSValue valueWithCGRect:CGRectMake(125.0, 548.0, 123.0, 64.0)];
    NSValue *point4 = [NSValue valueWithCGRect:CGRectMake(100.0, 464.0, 64.0, 123.0)];
    NSValue *point5 = [NSValue valueWithCGRect:CGRectMake(209.0, 464.0, 64.0, 123.0)];
    NSArray *pointArray = @[point1,point2,point3,point4,point5];
    NSArray *imageArray = @[@"school",@"homepage_phone",@"homepage_school",@"homepage_location",@"homepage_chat"];
    
    for (int i = 0; i < [pointArray count]; i++)
    {
        CGRect frame = [pointArray[i] CGRectValue];
        UIButton *button = [CreateViewTool createButtonWithFrame:CGRectMake(frame.origin.x * CURRENT_SCALE, frame.origin.y * CURRENT_SCALE, frame.size.width * CURRENT_SCALE, frame.size.height * CURRENT_SCALE) buttonImage:imageArray[i] selectorName:@"" tagDelegate:self];
        [self.view addSubview:button];
    }
}


#pragma mark 点击头像按钮
- (void)babyButtonPressed:(UIButton *)sender
{
    //[[SliderViewController sharedSliderController] showLeftViewController];
    [[MainSideViewController sharedSliderController] showLeftViewController:YES];
}

#pragma mark 点击更多按钮
- (void)moreButtonPressed:(UIButton *)sender
{
    //[[SliderViewController sharedSliderController] showRightViewController];
    [[MainSideViewController sharedSliderController] showRightViewController:YES];
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
