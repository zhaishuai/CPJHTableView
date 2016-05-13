//
//  ViewController.m
//  CPJHTableView
//
//  Created by shuaizhai on 5/13/16.
//  Copyright © 2016 cpj. All rights reserved.
//

#import "ViewController.h"
#import "CPJHTableView.h"

@interface ViewController ()<CPJHTableViewDataSource, CPJHTableViewDelegate>

@property (nonatomic)CPJHTableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor lightTextColor];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(CPJHTableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (CGFloat)tableView:(CPJHTableView *)tableView widthForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CPJHTableView *)tableView{
    if(_tableView == nil){
        _tableView            = [[CPJHTableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _tableView.delegate   = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}



@end
