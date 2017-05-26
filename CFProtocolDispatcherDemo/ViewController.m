//
//  ViewController.m
//  CFProtocolDispatcherDemo
//
//  Created by wjc on 2017/5/26.
//  Copyright © 2017年 CityFire. All rights reserved.
//

#import "ViewController.h"
#import "FirstMethodViewController.h"
#import "SecondMethodViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)firstMethod:(id)sender {
    FirstMethodViewController *firstVC = [FirstMethodViewController new];
    [self.navigationController pushViewController:firstVC animated:YES];
}

- (IBAction)secondMethod:(id)sender {
    SecondMethodViewController *secondVC = [SecondMethodViewController new];
    [self.navigationController pushViewController:secondVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
