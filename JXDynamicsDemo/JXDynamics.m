//
//  JXDynamics.m
//  JXDynamicsDemo
//
//  Created by FDZ021 on 16/8/24.
//  Copyright © 2016年 BFMobile. All rights reserved.
//

#import "JXDynamics.h"

@interface JXDynamics(){
    UIDynamicAnimator* _animator;
    UIView *_referenceView;
}

@end

@implementation JXDynamics


-(void)setUpWithAnchor:(CGPoint)anchor inView:(UIView*)view{
    
    self.backgroundColor = [UIColor orangeColor];
    _referenceView = view;
    
    //KVO，在手指离开以后继续画线
    [self addObserver:self forKeyPath:@"center" options:NSKeyValueObservingOptionNew context:nil];
    
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:_referenceView];
    _gravity = [[UIGravityBehavior alloc] initWithItems:@[self]];
    [_animator addBehavior:_gravity];
    
    _attach = [[UIAttachmentBehavior alloc]initWithItem:self offsetFromCenter:UIOffsetMake(0, -self.bounds.size.height*0.5) attachedToAnchor:anchor];
    _attach.length = 100.0;
    _attach.damping = 0.1;
    _attach.frequency = 0.6;
    [_animator addBehavior:_attach];
    
    _itemBehaviour = [[UIDynamicItemBehavior alloc] initWithItems:@[self]];
    _itemBehaviour.elasticity = 0.6;
    [_animator addBehavior:_itemBehaviour];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
    
}

#pragma mark - Line Property

-(void)setLineLength:(CGFloat)lineLength{
    _lineLength = lineLength;
    _attach.length = lineLength;
}

-(void)setLineWidth:(CGFloat)lineWidth{
    _lineWidth = lineWidth;
    _lineLayer.lineWidth = _lineWidth;
}

-(void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    _lineLayer.strokeColor = _lineColor.CGColor;
}

-(void)setDamping:(CGFloat)damping{
    if (0 <= damping && damping <= 1) {
        _damping = damping;
        _attach.damping = damping;
    }
}

#pragma mark - Line

-(CAShapeLayer*)lineLayer{
    if (nil == _lineLayer) {
        _lineLayer = [CAShapeLayer layer];
        _lineLayer.strokeColor = _lineColor.CGColor?:[UIColor redColor].CGColor;
        _lineLayer.fillColor = [UIColor clearColor].CGColor;
        _lineLayer.lineWidth = _lineWidth?:1.5;
        _lineLayer.lineJoin = kCALineJoinRound;
        _lineLayer.strokeEnd = 3.0f;
        [_referenceView.layer addSublayer:_lineLayer];
    }
    return _lineLayer;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    [self updateLine];
}

-(void)updateLine{
    CGPoint platePoint = [_referenceView convertPoint:CGPointMake(CGRectGetMidX(self.bounds), 0) fromView:self];
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:_attach.anchorPoint];
    [bezierPath addLineToPoint:platePoint];
    self.lineLayer.path = bezierPath.CGPath;
}


#pragma mark - GestureRecognize

- (void)tap:(UIGestureRecognizer *)pan{
    if (nil != _tapBlock) {
        _tapBlock();
    }
}


- (void)pan:(UIGestureRecognizer *)pan
{
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            [_animator removeAllBehaviors];
            break;
        case UIGestureRecognizerStateChanged:{
            CGPoint point = [pan locationInView:_referenceView];
            self.center = point;
        }break;
        case UIGestureRecognizerStateEnded:
            [_animator addBehavior:_gravity];
            [_animator addBehavior:_attach];
            break;
        default:
            break;
    }
}

@end
