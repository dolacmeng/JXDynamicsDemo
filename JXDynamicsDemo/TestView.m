//
//  TestView.m
//  JXDynamicsDemo
//
//  Created by FDZ021 on 16/8/24.
//  Copyright © 2016年 BFMobile. All rights reserved.
//

#import "TestView.h"

@implementation TestView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
        label.text = @"测试";
        [self addSubview:label];
    }
    return self;
}

@end
