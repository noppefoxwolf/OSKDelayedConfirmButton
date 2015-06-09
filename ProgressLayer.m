//
//  progressLayer.m
//  OSKDelayedConfirmationAlertDemo
//
//  Created by Tomoya_Hirano on H27/06/10.
//  Copyright (c) 平成27年 Tomoya_Hirano. All rights reserved.
//

#import "ProgressLayer.h"

@interface ProgressLayer (){
    CAShapeLayer *_progressLayer;
}
@end

@implementation ProgressLayer

- (instancetype)init {
    if ((self = [super init])){
        [self setupLayer];
    }
    return self;
}

- (void)layoutSublayers {
    self.path = [self drawPathWithArcCenter];
    _progressLayer.path = [self drawPathWithArcCenter];
    [super layoutSublayers];
}

- (void)setupLayer {
    self.path = [self drawPathWithArcCenter];
    self.fillColor = [UIColor clearColor].CGColor;
    self.strokeColor = [UIColor whiteColor].CGColor;
    self.lineWidth = 5;
    
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.path = [self drawPathWithArcCenter];
    _progressLayer.fillColor = [UIColor clearColor].CGColor;
    _progressLayer.strokeColor = [UIColor colorWithRed:0.588 green:0.745 blue:0.996 alpha:1].CGColor;
    _progressLayer.lineWidth = 6;
    _progressLayer.lineCap = kCALineCapSquare;
    _progressLayer.lineJoin = kCALineJoinRound;
    [self addSublayer:_progressLayer];
}

- (CGPathRef)drawPathWithArcCenter {
    CGFloat position_y = self.frame.size.height/2;
    CGFloat position_x = self.frame.size.width/2;
    return [UIBezierPath bezierPathWithArcCenter:CGPointMake(position_x, position_y)
                                          radius:position_y
                                      startAngle:(-M_PI/2)
                                        endAngle:(3*M_PI/2)
                                       clockwise:YES].CGPath;
}

- (void)start{
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        CAAnimation* animation = [_progressLayer animationForKey:@"ani"];
        if (animation) {
            [self.completion_delegate progressLayer:self didfinish:true];
            [_progressLayer removeAnimationForKey:@"ani"];
        }else{
            [self.completion_delegate progressLayer:self didfinish:false];
        }
    }];
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.duration = 3.0;
    pathAnimation.fromValue = @(0.0);
    pathAnimation.toValue = @(1.0);
    pathAnimation.removedOnCompletion = false;
    [_progressLayer addAnimation:pathAnimation forKey:@"ani"];
    [CATransaction commit];
}

- (void)stop{
    [_progressLayer removeAllAnimations];
    self.opacity = 0;
}

@end
