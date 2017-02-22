//
//  ViewController.m
//  EmptyDataKit   GitHub: https://github.com/CepheusSun/EmptyDataKit
//
//  Created by CepheusSun on 16/9/6.
//  Copyright © 2016年 CepheusSun. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "EDKTableViewController.h"
#import "EmptyDataKit.h"

@interface EDKTableViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation EDKTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
    
    {
        __weak typeof(self) weakSelf = self;
        EmptyDataKit *kit = [[EmptyDataKit alloc] initWithEdk_Image:[UIImage imageNamed:@"common_pic_loadFail"] edk_Message:@"aaa" edk_reloadHandler:^{
            [weakSelf getData];
        }];
        kit.edk_error_image = [UIImage imageNamed: @""];
        kit.edk_error_message = @"网络错误";
        self.tableView.emptyKit = kit;
    }
}

#pragma mark - delegate & datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *indentifier = @"reuseIdentifier";
    UITableViewCell *cell        = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark - getData
- (void)getData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (NSInteger i = 0; i < 20; i++) {
            [self.dataSource addObject:[NSString stringWithFormat:@"这是第%ld条数据", i]];
        }
        self.tableView.emptyKit.edk_type = EDK_None;
        [self.tableView reloadData];
    });
}

- (IBAction)getDataClicked:(id)sender {
    [self getData];
}

- (IBAction)refreshData:(id)sender {
    [self.dataSource removeAllObjects];
    self.tableView.emptyKit.edk_type = EDK_Error;
    [self.tableView reloadData];
}

#pragma mark - lazyLoad
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end
