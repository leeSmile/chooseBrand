//
//  ChooseCarController.m
//  chooseBrand
//
//  Created by 祥云创想 on 16/7/5.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "ChooseCarController.h"
#import "CarHeadView.h"
#import "CarCell.h"
#import "HotCarCell.h"
#import "HotCarHeadView.h"
#import "UIView+LXExtension.h"
#import "CarModel.h"
#import "SeriesCarCell.h"
#import "ChooseDisplaceController.h"

#import "LXPlateNetDataTool.h"
#define KeyWindow  [UIApplication sharedApplication].keyWindow
// 头部Cell的高度
static float HeadCellHeight = 110;
// 其它Cell的高度
static float OtherCellHeight = 50;
// HeaderView的高度
static float HeaderViewHeight = 30;

static float HotViewHeight = 49;
static NSString *HotCellIdentifier = @"HotCellIdentifier";
static NSString *OtherCellIdentifier = @"OtherCellIdentifier";

static NSString *NextCellIdentifier = @"NextCellIdentifier";
static NSString *SeriesCarCellIdentifier = @"SeriesCarCellIdentifier";

@interface ChooseCarController ()<UIGestureRecognizerDelegate,HotCarCellDelegate>
/**
 *  品牌型号数组
 */
@property (nonatomic, strong) NSMutableArray *brandSourceArr;
/**
 *  热门品牌型号数组
 */
@property (nonatomic, strong) NSMutableArray *hotBrandSourceArr;
/**
 *  品牌系列数组
 */
@property (nonatomic, strong) NSMutableArray *seriesSourceArr;
/**
 *  侧滑tableView
 */
@property (nonatomic, strong) UITableView *nextTavleView;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) CarModel *selecterModel;

@property (nonatomic, strong) SeriesCarCell *nextSelecterCell;

@property (nonatomic, strong) NSMutableArray *indexTitleArr;

@property (nonatomic, strong) LXPlateNetDataTool *tools;
@end

@implementation ChooseCarController




- (void)viewDidLoad
{
    [super viewDidLoad];
    [self baseSetup];
    [self netWork];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.bgView.alpha = 1;
    }];
    
}

- (void)netWork
{
    [self.tools getHotPlateData:^(id json) {
        if ([json isKindOfClass:[NSArray class]]) {
            self.hotBrandSourceArr = json;
            NSIndexSet *set = [NSIndexSet indexSetWithIndex:0];
            [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
        }
        
    }];
    

    
    [self.tools getPlateData:^(id json, NSMutableArray *indexTitleArr) {
        if ([json isKindOfClass:[NSArray class]]) {
            self.brandSourceArr = json;
            self.indexTitleArr =indexTitleArr;
            [self.tableView reloadData];
        }
        
    }];
}

- (void)getCarModelDataWithModel:(CarModel *)model
{
    [self.seriesSourceArr removeAllObjects];
    [self.nextTavleView reloadData];
    
    [self.tools getCarModelDataWithCarName:model.carname block:^(id json) {
        if ([json isKindOfClass:[NSString class]]) {
            
        }
        if ([json isKindOfClass:[NSArray class]]) {
            self.seriesSourceArr = json;
        }
        [self.nextTavleView reloadData];
    }];
}


- (void)baseSetup
{
    self.navigationItem.title = @"请选择品牌";
    
    self.tableView.sectionIndexColor = [UIColor grayColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    //注册
    [self.tableView registerClass:[CarCell class] forCellReuseIdentifier:OtherCellIdentifier];
    [self.tableView registerClass:[HotCarCell class] forCellReuseIdentifier:HotCellIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
    //添加侧滑视图
    [KeyWindow addSubview:self.bgView];
    

}

#pragma mark -dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //
    if (tableView.tag == 99) {
        return 1;
    }
    //测试数据
    return 10;
//    return self.brandSourceArr.count + 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 99) {
        return 10;
//        return self.seriesSourceArr.count;
    }
    
    if (section == 0) {
        return 1;
    }
//    NSMutableArray *arr =self.brandSourceArr[section-1];
//    return arr.count;
    return 5;
}

#pragma mark -tableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 99) {
        SeriesCarCell *cell = [tableView dequeueReusableCellWithIdentifier:SeriesCarCellIdentifier];
        //测试数据 取消模型传递
//        cell.carFamilyModel = self.seriesSourceArr[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    if (indexPath.section == 0 &&indexPath.row == 0) {
        HotCarCell *cell = [tableView dequeueReusableCellWithIdentifier:HotCellIdentifier];

        //测试数据 取消模型传递
//        if (self.hotBrandSourceArr.count) {
//            cell.CarModelArr = self.hotBrandSourceArr;
//        }
        
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }

    CarCell *cell = [tableView dequeueReusableCellWithIdentifier:OtherCellIdentifier];

//    cell.CarModel = self.brandSourceArr[indexPath.section -1][indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if (tableView.tag == 99) {
//        return 0;
//    }
    if (section == 0 ) {
        return HotViewHeight;
    }
    return HeaderViewHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    if (section == 0) {
        
        HotCarHeadView *headView = [[HotCarHeadView alloc] initWithFrame:CGRectMake(0, 0, 0, HeaderViewHeight)];
        if (tableView.tag == 99) {

            headView.CarModel = self.selecterModel;
            
            return headView;
        }
        return headView;
    }
    
    CarHeadView *headView = [[CarHeadView alloc] initWithFrame:CGRectMake(0, 0, 0, HeaderViewHeight)];

    headView.nameLable = self.indexTitleArr[section-1];
    return headView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 99) {
        return OtherCellHeight;
    }

    if (indexPath.section == 0 &&indexPath.row == 0) {
        return HeadCellHeight;
    }
    return OtherCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 99) {
        
        self.nextSelecterCell.selecterImage.hidden = YES;
        SeriesCarCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.selecterImage.hidden = NO;
        self.nextSelecterCell = cell;
        
        ChooseDisplaceController *vc = [[ChooseDisplaceController alloc] init];
        
        //测试数据 关掉赋值 其它几个控制机器一样
        
        //拿到选中的那个系列名字  +  车品牌（selecterModel）
//        CarFamilyModel *carFamilyModel = self.seriesSourceArr[indexPath.row];
//        
//        NSString *nextHead = [NSString stringWithFormat:@"%@ %@",self.selecterModel.carname, carFamilyModel.FamilyName];
//        vc.headLable = nextHead;
//        vc.carName = self.selecterModel.carname;
//        vc.carID = carFamilyModel.FamilyId;
        
        [self.navigationController pushViewController:vc animated:YES];

        
        
        [UIView animateWithDuration:0.23 animations:^{
            self.bgView.alpha = 0;
        }];

        return ;
    }

//    self.selecterModel = self.brandSourceArr[indexPath.section -1][indexPath.row];
    [self getCarModelDataWithModel:self.selecterModel];
    [self animation];
}



#pragma mark -IndexTitles
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if (tableView.tag == 99) {
        return nil;
    }
    return self.indexTitleArr;
}

#pragma mark -UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {//如果当前是tableView
        //做自己想做的事
        return NO;
    }
    return YES;
    
}

#pragma mark -HotCarCellDelegate

-(void)tableViewCell:(HotCarCell *)tableViewCell didSelectBtnWithCarModel:(CarModel *)CarModel
{
//    NSLog(@"%@",CarModel.carname);
    self.selecterModel = CarModel;
    [self getCarModelDataWithModel:self.selecterModel];
    
    [self animation];
}
#pragma mark - get  set  mothed

- (NSMutableArray *)indexTitleArr
{
    if (!_indexTitleArr) {
        _indexTitleArr = [NSMutableArray array];
        NSArray *arr = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R"];
        [_indexTitleArr addObjectsFromArray:arr];
    }
    return _indexTitleArr;
}

- (LXPlateNetDataTool *)tools
{
    if (!_tools) {
        _tools = [LXPlateNetDataTool new];
    }
    return _tools;
}

- (NSMutableArray *)hotBrandSourceArr
{
    if (!_hotBrandSourceArr) {
        _hotBrandSourceArr = [NSMutableArray array];

    }
    return _hotBrandSourceArr;
}

- (NSMutableArray *)brandSourceArr
{
    if (!_brandSourceArr) {
        _brandSourceArr = [NSMutableArray array];
    }
    return _brandSourceArr;
}

- (NSMutableArray *)seriesSourceArr
{
    if (!_seriesSourceArr) {
        _seriesSourceArr = [NSMutableArray array];
    }
    return _seriesSourceArr;
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.frame = self.view.frame;
        _bgView.lx_x = self.view.lx_width;
        _bgView.lx_y = 64;
        _bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];

        [self.bgView addSubview:self.nextTavleView];
        
        //添加手势
        UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectClick)];
        tag.delegate = self;
        [_bgView addGestureRecognizer:tag];
        
        

        //设置子控件位置
        self.nextTavleView.lx_x = 100;
        self.nextTavleView.lx_y = 0;
        self.nextTavleView.lx_width = self.view.lx_width - 100;
        self.nextTavleView.lx_height = self.view.lx_height;


    }
    return _bgView;
}

- (UITableView *)nextTavleView
{
    if (!_nextTavleView) {
        _nextTavleView = [[UITableView alloc] init];
        _nextTavleView.tag = 99;
        _nextTavleView.dataSource = self;
        _nextTavleView.delegate = self;
        _nextTavleView.tableFooterView = [UIView new];
        _nextTavleView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
        _nextTavleView.separatorStyle = NO;
        [_nextTavleView registerClass:[SeriesCarCell class] forCellReuseIdentifier:SeriesCarCellIdentifier];
    }
    return _nextTavleView;
}

#pragma mark - other
- (void)animation
{
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.bgView.lx_x = 0;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark -手势
- (void)selectClick
{
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.bgView.lx_x = self.view.lx_width;
    } completion:^(BOOL finished) {
        self.selecterModel = nil;
        self.nextSelecterCell.selecterImage.hidden = YES;
        [self.nextTavleView reloadData];
    }];
}

- (void)dealloc
{
    [self.bgView removeFromSuperview];
}
@end
