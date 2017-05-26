//
//  UITableViewDelegateDataSource_A.m
//  CFProtocolDispatcherDemo
//
//  Created by wjc on 2017/5/26.
//  Copyright © 2017年 CityFire. All rights reserved.
//

#import "UITableViewDelegateDataSource_A.h"

@implementation UITableViewDelegateDataSource_A

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"A");
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"A - %@",[@(indexPath.row) stringValue]];
    return cell;
}

@end
