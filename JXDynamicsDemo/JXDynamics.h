//
//  JXDynamics.h
//  JXDynamicsDemo
//
//  Created by JackXu on 16/8/24.
//  Copyright © 2016年 BFMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapBlock)();

@interface JXDynamics : UIView

@property (strong,nonatomic) CAShapeLayer *lineLayer;
@property (strong,nonatomic) UIColor *lineColor;
@property (assign,nonatomic) CGFloat lineWidth;
@property (strong,nonatomic) UIGravityBehavior *gravity;
@property (strong,nonatomic) UIAttachmentBehavior *attach;
@property (strong,nonatomic) UIDynamicItemBehavior *itemBehaviour;
@property (strong,nonatomic) UICollisionBehavior *collision;

@property (copy,nonatomic) TapBlock tapBlock;

-(void)setUpWithAnchor:(CGPoint)anchor inView:(UIView*)view;

@end
