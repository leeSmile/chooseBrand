//
//  ChooseStallController.m
//  chooseBrand
//
//  Created by 祥云创想 on 16/7/6.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "ChooseStallController.h"
#import "SeriesCarCell.h"
#import "CarHeadView.h"
#import "LXPlateNetDataTool.h"
#import "ChooseVersionController.h"
static NSString *CellIdentifier = @"NextCellIdentifier";
/** RGB颜色 */
#define rgb255(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]
/** 灰色 */
#define Color(v) rgb255(v, v, v)
@interface ChooseStallController ()
/**
 *  型号档位数组
 */
@property (nonatomic, strong) NSMutableArray *brandStallArr;

@property (nonatomic, strong) SeriesCarCell *nextSelecterCell;
@property (nonatomic, strong) LXPlateNetDataTool *tools;
@end

@implementation ChooseStallController
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
    self.navigationItem.title = @"选择档位";
    self.tableView.tableFooterView = [UIView new];
    //注册
    [self.tableView registerClass:[SeriesCarCell class] forCellReuseIdentifier:CellIdentifier];
}
- (void)netWork
{
    [self.tools getCarGearBoxDataWithCarName:self.carName carID:self.carID enginedesc:self.enginedesc block:^(id json) {
        if ([json isKindOfClass:[NSArray class]]) {
            self.brandStallArr = json;
            
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
//    return self.brandStallArr.count;
    return 4;
}
#pragma mark -tableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SeriesCarCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (self.brandStallArr.count) {
//        cell.carName.text = self.brandStallArr[indexPath.row];
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
    
    ChooseVersionController *vc = [[ChooseVersionController alloc] init];
//    vc.carName = self.carName;
//    vc.carID = self.carID;
//    vc.enginedesc = self.enginedesc;
//    vc.gearboxtype = self.brandStallArr[indexPath.row];
//    
//    vc.headLable = [NSString stringWithFormat:@"%@ %@",self.headLable, self.brandStallArr[indexPath.row]];
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
- (NSMutableArray *)brandStallArr
{
    if (!_brandStallArr) {
        _brandStallArr = [NSMutableArray array];
    }
    return _brandStallArr;
}
@end
