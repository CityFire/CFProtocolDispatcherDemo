//
//  FirstMethodViewController.m
//  CFProtocolDispatcherDemo
//
//  Created by wjc on 2017/5/26.
//  Copyright © 2017年 CityFire. All rights reserved.
//

#import "FirstMethodViewController.h"
#import "UITableViewDelegateDataSource_A.h"
#import "UITableViewDelegateDataSource_B.h"
#import "CFProtocolDispatcher.h"

@interface FirstMethodViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableViewDelegateDataSource_A *delegateSource_A;
@property (nonatomic, strong) UITableViewDelegateDataSource_B *delegateSource_B;

@end

@implementation FirstMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.tableView];
    
    self.delegateSource_A = [UITableViewDelegateDataSource_A new];
    self.delegateSource_B = [UITableViewDelegateDataSource_B new];
    
    // A = 0
    // B = 1
    NSUInteger type = 0;
    
    self.tableView.delegate = [CFProtocolDispatcher dispatcherProtocol:@protocol(UITableViewDelegate) withIndexImplementor:@(type) toImplementors:@[self.delegateSource_A, self.delegateSource_B]];
    self.tableView.dataSource = [CFProtocolDispatcher  dispatcherProtocol:@protocol(UITableViewDataSource) withIndexImplementor:@(type) toImplementors:@[self.delegateSource_A, self.delegateSource_B]];
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
