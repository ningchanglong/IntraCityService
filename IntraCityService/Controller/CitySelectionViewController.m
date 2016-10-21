//
//  CitySelectionViewController.m
//  CitySelection
//
//  Created by ioi on 16/9/18.
//  Copyright © 2016年 ningchanglong. All rights reserved.
//

#import "CitySelectionViewController.h"
#import "HotCityTableViewCell.h"
#import "TransformMandarinLatin.h"
#import "LocationTableViewCell.h"
#import <AMapLocationKit/AMapLocationKit.h>
#define SCR_W [UIScreen mainScreen].bounds.size.width
#define SCR_H [UIScreen mainScreen].bounds.size.height
@interface CitySelectionViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,AMapLocationManagerDelegate>
/**
 * 索引数据源
 */
@property (nonatomic,strong)NSMutableArray *indexMarr;
/**
 * 热门城市数据源
 */
@property (nonatomic,strong)NSArray *dataArr;

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UITextField *searchTFd;
@property (nonatomic,strong)UIButton *cancelBtn;
@property (nonatomic,assign)BOOL isSearch;
@property (nonatomic,assign)BOOL isSuccess;
@property (nonatomic,strong)NSArray *citiesArr;
@property (nonatomic,strong)NSMutableArray *searchCities;
@property (nonatomic,strong)NSArray *cities;
@property (nonatomic,strong)AMapLocationManager *locationManager;
@property (nonatomic,strong)NSString *currentLocation;
@end

@implementation CitySelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"城市选择";
    [self configLocationManager];
    //所有的城市
    [self getCities];
    [self createTableView];
    [self starLocation];
}

#pragma mark - init

- (NSString *)currentLocation
{
    if (!_currentLocation) {
        _currentLocation = @"定位中......";
    }
    return _currentLocation;
}

- (NSMutableArray *)indexMarr
{
    if (!_indexMarr) {
        _indexMarr = [[NSMutableArray alloc] init];
    }
    return _indexMarr;
}

- (NSArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = @[@"北京",@"上海",@"广州",@"深圳",@"沈阳",@"大连",@"杭州",@"南京"];
    }
    return _dataArr;
}

- (void)getCities
{
    self.cities = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cityList.plist" ofType:nil]];
    self.searchCities = [NSMutableArray array];
    for (NSDictionary *dic in self.cities) {
        [self.indexMarr addObject:dic[@"name"]];
        for (NSDictionary *dict in dic[@"cities"]) {
            [self.searchCities addObject:dict];
        }
    }
}


- (void)configLocationManager
{
    self.locationManager = [[AMapLocationManager alloc] init];
    
    [self.locationManager setDelegate:self];
    
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
//    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];

}

- (void)createTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    //如果界面主体控制器只是tableVie，可以创建继承于UITableViewController的控制器
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCR_W, SCR_H - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    // 更改索引的背景颜色:
    _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    // 索引颜色
    _tableView.sectionIndexColor = [UIColor redColor];
    
    [self.view addSubview:_tableView];
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCR_W, 50)];
    headView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = headView;
    //搜索框
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCR_W, 50)];
    searchBar.placeholder = @"请输入汉字或拼音";
        searchBar.searchBarStyle = UISearchBarStyleMinimal;
    //    searchBar.showsCancelButton = YES;
    searchBar.delegate = self;
    [headView addSubview:searchBar];
    [_tableView registerNib:[UINib nibWithNibName:@"LocationTableViewCell" bundle:nil] forCellReuseIdentifier:@"LocationTableViewCell"];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELL"];
    [_tableView registerClass:[HotCityTableViewCell class] forCellReuseIdentifier:@"HOTCELL"];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (!self.isSearch) {
        return self.indexMarr.count;
    } else {
        return 1;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!self.isSearch) {
        if (section == 0 || section == 1) {
            return 1;
        } else {
            return [self.cities[section][@"cities"] count];
        }
    } else {
        return self.citiesArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (!self.isSearch) {
        if (indexPath.section == 1) {
            HotCityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HOTCELL" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.hotCityArr = self.dataArr;
            [cell setCheckBlock:^(NSInteger index) {
//                NSLog(@"%ld",index);
                self.title = self.dataArr[index];
            }];
            return cell;
        } else if (indexPath.section == 0) {
             LocationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LocationTableViewCell" forIndexPath:indexPath];
            if (self.isSuccess == YES) {
                cell.LocationBtn.hidden = NO;
            }else {
                cell.LocationBtn.hidden = YES;
            }
            cell.locationLab.text = self.currentLocation;
            __weak typeof(self)weakSelf = self;
            [cell setLocationBlock:^{
                self.currentLocation = @"定位中......";
                [self.tableView reloadData];
                [weakSelf starLocation];
            }];
            [cell setCurrentLocationBlock:^{
                [weakSelf showLocation:self.currentLocation];
            }];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        } else {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
            NSDictionary *dict = self.cities[indexPath.section][@"cities"][indexPath.row];
//            NSLog(@"++++++%@",dict[@"name"]);
            cell.textLabel.text = dict[@"name"];
            //    cell.textLabel.text = @"ceshi";
            return cell;
        }
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.textLabel.text = self.citiesArr[indexPath.row][@"name"];
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.isSearch) {
        if (indexPath.section > 1) {
            [self showLocation:self.cities[indexPath.section][@"cities"][indexPath.row][@"name"]];
        }
    } else {
        [self showLocation:self.citiesArr[indexPath.row][@"name"]];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat H;
    if (!self.isSearch) {
        if (indexPath.section == 0) {
            H = 44;
        }else if (indexPath.section == 1){
            H = 100;
        }else{
            return 44;
        }
    } else {
        H = 44;
    }
    
    return H;
}

//每个分区的页眉
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (!self.isSearch) {
        if (section == 0) {
            return @"定位到的城市";
        }else if (section == 1) {
            return @"热门城市";
        }else{
            return self.indexMarr[section];
        }
    } else {
        return nil;
    }
}

//索引目录
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (!self.isSearch) {
        return self.indexMarr;
    } else {
        return 0;
    }
}

// 点击目录
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    // 获取所点目录对应的indexPath值
    NSIndexPath *selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:index];
    
    // 让table滚动到对应的indexPath位置
    [tableView scrollToRowAtIndexPath:selectIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    return index;
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"%s",__func__);
    searchBar.showsCancelButton = YES;
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"%s",__func__);
    searchBar.showsCancelButton = NO;
    [searchBar endEditing:YES];
    self.isSearch = NO;
    [self.tableView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"%s--%@",__func__,searchText);
    self.isSearch = YES;
    [self search:searchText];
    [self.tableView reloadData];
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.25 animations:^{
        self.cancelBtn.hidden = NO;
        textField.frame = CGRectMake(5, 10, SCR_W - 30 - 50, 30);
        self.cancelBtn.frame = CGRectMake(CGRectGetMaxX(self.searchTFd.frame) + 5, CGRectGetMinY(self.searchTFd.frame), 45, 30);
    }];
    
    return YES;
}


- (void)search:(NSString *)text
{
    NSString *search = [TransformMandarinLatin transform:text];
    NSLog(@"=====%@",search);
    NSPredicate *pre1 = [NSPredicate predicateWithFormat:@"pinyin BEGINSWITH[cd]%@",search.lowercaseString];
    self.citiesArr = [self.searchCities filteredArrayUsingPredicate:pre1];
//    NSLog(@"******%@",self.citiesArr);
}

#pragma mark - starLocation
- (void)starLocation
{
    // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error){
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            self.currentLocation = @"定位失败!";
//            if (error.code == AMapLocationErrorLocateFailed)
//            {
//                return;
//            }
            self.isSuccess = NO;
        }else {
            self.isSuccess = YES;
        }
        
        NSLog(@"location:%f----%f", location.coordinate.latitude,location.coordinate.longitude);
        
        if (regeocode)
        {
            NSLog(@"reGeocode:%@", regeocode);
            self.currentLocation = regeocode.city;
        }
        
        [self.tableView reloadData];
    }];
}

- (void)showLocation:(NSString *)location
{
    NSNotification *noti = [NSNotification notificationWithName:@"Location" object:location];
    [[NSNotificationCenter defaultCenter] postNotification:noti];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
