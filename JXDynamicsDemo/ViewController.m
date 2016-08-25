//
//  ViewController.m
//  JXDynamicsDemo
//
//  Created by JackXu on 16/8/24.
//  Copyright © 2016年 BFMobile. All rights reserved.
//

#import "ViewController.h"
#import "JXDynamics.h"
#import "TestView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //setUpWithAnchor:inView: must be called after addSubview
    JXDynamics *dy = [[JXDynamics alloc] initWithFrame:CGRectMake(110, 200, 50, 50)];
    [self.view addSubview:dy];
    [dy setUpWithAnchor:CGPointMake(100, 100) inView:self.view];
    
//    UILabel *label = [[UILabel alloc] initWithFrame:dy.bounds];
//    label.text = @"Hello";
//    label.textAlignment = NSTextAlignmentCenter;
//    [dy addSubview:label];
    
    //click Block
    dy.tapBlock = ^{
        NSLog(@"tap!");
    };
    
//    TestView *dy = [[TestView alloc] initWithFrame:CGRectMake(110, 200, 50, 50)];
//    [self.view addSubview:dy];
//    [dy setUpWithAnchor:CGPointMake(100, 100) inView:self.view];
}


@end
