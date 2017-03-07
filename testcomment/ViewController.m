//
//  ViewController.m
//  testcomment
//
//  Created by macos on 2017/3/3.
//  Copyright © 2017年 macos. All rights reserved.
//

#import "ViewController.h"
#import "comModel.h"
#import <Masonry/Masonry.h>
#import "CirOfFriViewCell.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource> {

    UITableView *_tableView;
    NSMutableArray *_dataArray;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataArray];
    [self layoutSubviews];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)initDataArray {
    
    _dataArray = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 6; i ++) {
        comModel *model = [[comModel alloc] init];
        
        model.userName = [NSString stringWithFormat:@"用户%ld", i];
        model.userIconUrl = @"http://fanyi.baidu.com/static/translation/img/header/logo_cbfea26.png";
        model.content = @"测试内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容。。。。。。。。。..........";
        model.postTime = @"2017-03-03 10:10:10";
        model.imgArray = [NSMutableArray array];
        model.commArray = [NSMutableArray array];
        
        for (NSInteger j = 0; j <= i; j ++) {
            NSString *comment = [NSString stringWithFormat:@"%ld用户的评论",j];
            [model.commArray addObject:comment];
            [model.imgArray addObject:@"http://fanyi.baidu.com/static/translation/img/header/logo_cbfea26.png"];
        }
        [_dataArray addObject:model];
    }
}

- (void)layoutSubviews {
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseId = @"reuesId";
    CirOfFriViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[CirOfFriViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    comModel *model = _dataArray[indexPath.section];

    [cell postCommentWithCallBack:^(NSString *comment) {
        [model.commArray addObject:comment];
        [_tableView reloadData];
    }];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return (!section) ? 0.0001f : 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 5)];
    headerView.backgroundColor = [UIColor grayColor];
    headerView.alpha = 0.3;
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    CirOfFriViewCell *cell = [[CirOfFriViewCell alloc] init];
    cell.model = _dataArray[indexPath.section];
    return cell.cellHeight;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
