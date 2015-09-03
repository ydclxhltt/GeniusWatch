//
//  LeftViewController.m
//  GeniusWatch
//
//  Created by clei on 15/8/21.
//  Copyright (c) 2015年 chenlei. All rights reserved.
//

#import "LeftViewController.h"
#import "iCarousel.h"


#define NUMBER_OF_VISIBLE_ITEMS     2
#define ITEM_SPACING                160.0
#define INCLUDE_PLACEHOLDERS        YES
#define SPACE_Y                     44.0
#define ROW_HEIGHT                  60.0
#define ADD_Y                       20.0 * CURRENT_SCALE


@interface LeftViewController ()<iCarouselDataSource,iCarouselDelegate,UITableViewDataSource,UITableViewDelegate>
{
    iCarousel *carouselView;
}
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *imageArray;
@end

@implementation LeftViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.titleArray = @[@"宝贝资料",@"手表设置",@"关于手表"];
    self.imageArray = @[@"personal_baby",@"personal_watch_set",@"personal_watch"];
    
    //添加试图方便整体移动
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
    [self addTableView];
}

//添加背景图
- (void)addBgImageView
{
    UIImageView *imageView = [CreateViewTool createImageViewWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height) placeholderImage:[UIImage imageNamed:@"left_bg"]];
    [self.contentView addSubview:imageView];
}

//添加头视图
- (void)addCoverFlowView
{
    //create carousel
    UIImage *image = [UIImage imageNamed:@"baby_head_up"];
    float height = image.size.height * 2/3 * CURRENT_SCALE;
    float width = image.size.width * 2/3 * CURRENT_SCALE;
    carouselView = [[iCarousel alloc] initWithFrame:CGRectMake((LEFT_SIDE_WIDTH - width)/2, SPACE_Y, width, height)];
    carouselView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    carouselView.type = iCarouselTypeRotary;
    carouselView.delegate = self;
    carouselView.dataSource = self;
    [self.contentView addSubview:carouselView];
}

//添加tableView
- (void)addTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, carouselView.frame.size.height + carouselView.frame.origin.y + ADD_Y, LEFT_SIDE_WIDTH, ROW_HEIGHT * [self.titleArray count]) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.scrollEnabled = NO;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.contentView addSubview:tableView];
}

#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.titleArray count];
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
        cell.backgroundColor = [UIColor clearColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.imageView.transform = CGAffineTransformMakeScale(0.5, 0.5);
        //[[NSNotificationCenter defaultCenter] addObserver:@(cell.isSelected) forKeyPath:@"Selected" options:NSKeyValueObservingOptionNew context:nil];
    }
    
    cell.imageView.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    cell.textLabel.text = self.titleArray[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = FONT(16.0);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

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
        UIImage *image = [UIImage imageNamed:@"baby_head_up"];
        view = [CreateViewTool createRoundImageViewWithFrame:CGRectMake(0, 0, carousel.frame.size.width, carousel.frame.size.height) placeholderImage:image borderColor:[UIColor whiteColor] imageUrl:nil];
        [CommonTool setViewLayer:view withLayerColor:[UIColor whiteColor] bordWidth:1.0];
        [CommonTool clipView:view withCornerRadius:view.frame.size.width/2];
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
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * carouselView.itemWidth);
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
