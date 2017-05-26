//
//  SecondMethodViewController.m
//  CFProtocolDispatcherDemo
//
//  Created by wjc on 2017/5/26.
//  Copyright © 2017年 CityFire. All rights reserved.
//

#import "SecondMethodViewController.h"
#import "UITableViewDelegateDataSource_B.h"
#import "CFProtocolDispatcher.h"

@interface SecondMethodViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableViewDelegateDataSource_B *delegateSource_B;

@end

@implementation SecondMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.tableView];
    
    self.delegateSource_B = [UITableViewDelegateDataSource_B new];
    
    self.tableView.delegate = ProtocolDispatcher(UITableViewDelegate, self, self.delegateSource_B);
    self.tableView.dataSource = self.delegateSource_B;
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"%@", NSStringFromCGPoint(scrollView.contentOffset));
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"vc");
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
