//
//  ChooseDisplaceController.m
//  chooseBrand
//
//  Created by 祥云创想 on 16/7/6.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "ChooseDisplaceController.h"
#import "SeriesCarCell.h"
#import "CarHeadView.h"
#import "LXPlateNetDataTool.h"
#import "ChooseStallController.h"
static NSString *CellIdentifier = @"NextCellIdentifier";
/** RGB颜色 */
#define rgb255(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]
/** 灰色 */
#define Color(v) rgb255(v, v, v)
@interface ChooseDisplaceController ()
/**
 *  型号排量数组
 */
@property (nonatomic, strong) NSMutableArray *brandDisplaceArr;
@property (nonatomic, strong) SeriesCarCell *nextSelecterCell;

@property (nonatomic, strong) LXPlateNetDataTool *tools;
@end

@implementation ChooseDisplaceController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self baseSetup];
    [self netWork];
    
}

- (void)baseSetup

{
    self.tableView.separatorStyle = NO;
    self.tableView.backgroundColor = Color(242);
    self.navigationItem.title = @"请选择发动机排量";
    self.tableView.tableFooterView = [UIView new];
    //注册
    [self.tableView registerClass:[SeriesCarCell class] forCellReuseIdentifier:CellIdentifier];
}

- (void)netWork
{
    [self.tools getCarDisplaceDataWithCarName:self.carName carID:self.carID block:^(id json) {
        if ([json isKindOfClass:[NSArray class]]) {
            self.brandDisplaceArr = json;

            [self.tableView reloadData];
        }
    }];
}

#pragma mark -dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return self.brandDisplaceArr.count;
    return 4;
}
#pragma mark -tableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SeriesCarCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (self.brandDisplaceArr.count) {
//        cell.carName.text = self.brandDisplaceArr[indexPath.row];
//    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CarHeadView *headView = [[CarHeadView alloc] initWithFrame:CGRectMake(0, 0, 0, 50)];
    headView.nameLable = self.headLable;
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.nextSelecterCell.selecterImage.hidden = YES;
    SeriesCarCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selecterImage.hidden = NO;
    
    self.nextSelecterCell = cell;
    
    
    ChooseStallController *vc = [[ChooseStallController alloc] init];
//    vc.carName = self.carName;
//    vc.carID = self.carID;
//    vc.enginedesc = self.brandDisplaceArr[indexPath.row];
//    
//    vc.headLable = [NSString stringWithFormat:@"%@ %@",self.headLable,self.brandDisplaceArr[indexPath.row]];
    
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - get  set  mothed
- (LXPlateNetDataTool *)tools
{
    if (!_tools) {
        _tools = [LXPlateNetDataTool new];
    }
    return _tools;
}
- (NSMutableArray *)brandDisplaceArr
{
    if (!_brandDisplaceArr) {
        _brandDisplaceArr = [NSMutableArray array];
    }
    return _brandDisplaceArr;
}
@end
