//
//  UITableViewDelegateDataSource_B.m
//  CFProtocolDispatcherDemo
//
//  Created by wjc on 2017/5/26.
//  Copyright © 2017年 CityFire. All rights reserved.
//

#import "UITableViewDelegateDataSource_B.h"

@implementation UITableViewDelegateDataSource_B

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"B");
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
    cell.textLabel.text = [NSString stringWithFormat:@"B - %@",[@(indexPath.row) stringValue]];
    return cell;
}

@end
