//
//  LeftViewController.m
//  GeniusWatch
//
//  Created by clei on 15/8/21.
//  Copyright (c) 2015年 chenlei. All rights reserved.
//

#import "LeftViewController.h"
#import "iCarousel.h"


#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define NUMBER_OF_VISIBLE_ITEMS 2
#define ITEM_SPACING 120
#define INCLUDE_PLACEHOLDERS YES

@interface LeftViewController ()<iCarouselDataSource,iCarouselDelegate>
{
    iCarousel *carousel;
}
@end

@implementation LeftViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.contentView];

    [self initUI];
    
    // Do any additional setup after loading the view.
}

#pragma mark 初始化UI
- (void)initUI
{
    [self addBgImageView];
    [self addCoverFlowView];
}

//添加背景图
- (void)addBgImageView
{
    UIImageView *imageView = [CreateViewTool createImageViewWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height) placeholderImage:[UIImage imageNamed:@"left_bg"]];
    [self.view addSubview:imageView];
}

//添加头视图
- (void)addCoverFlowView
{
    //create carousel
    carousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, LeftContentOffset, 100.0)];
    carousel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    carousel.type = iCarouselTypeRotary;
    carousel.delegate = self;
    carousel.dataSource = self;
    [self.view addSubview:carousel];
}


#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return 2;
}

- (NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel
{
    //limit the number of items views loaded concurrently (for performance reasons)
    return NUMBER_OF_VISIBLE_ITEMS;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{

    //create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        ((UIImageView *)view).image = [UIImage imageNamed:@"baby_head_up.png"];
    }

    return view;
}

- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
    //note: placeholder views are only displayed if wrapping is disabled
    return INCLUDE_PLACEHOLDERS? 2: 0;
}

- (UIView *)carousel:(iCarousel *)carousel placeholderViewAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"baby_head_up.png"]];
    }
    
    
    return view;
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    //slightly wider than item view
    return ITEM_SPACING;
}

- (CGFloat)carousel:(iCarousel *)carousel itemAlphaForOffset:(CGFloat)offset
{
    //set opacity based on distance from camera
    return 1.0f - fminf(fmaxf(offset, 0.0f), 1.0f);
}

- (CATransform3D)carousel:(iCarousel *)_carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * carousel.itemWidth);
}

- (BOOL)carouselShouldWrap:(iCarousel *)carousel
{
    //wrap all carousels
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
