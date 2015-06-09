//
//  OSKDelayedConfirmButton.m
//  OSKDelayedConfirmationAlertDemo
//
//  Created by Tomoya_Hirano on H27/06/10.
//  Copyright (c) 平成27年 Tomoya_Hirano. All rights reserved.
//

#import "OSKDelayedConfirmButton.h"
#import "ProgressLayer.h"

@interface CloseView : UIView
@end

@interface OSKDelayedConfirmButton ()<ProgressLayerDelegate>{
    ProgressLayer*progressLayer;
    CloseView*centerView;
    
    void (^_confirm)(void);
    void (^_cancel)(void);
}
@end

@implementation OSKDelayedConfirmButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        progressLayer = [[ProgressLayer alloc] init];
        progressLayer.frame = frame;
        progressLayer.backgroundColor = [UIColor clearColor].CGColor;
        progressLayer.completion_delegate = self;
        [self.layer addSublayer:progressLayer];
        
        centerView = [[CloseView alloc] initWithFrame:frame];
        centerView.backgroundColor = [UIColor colorWithRed:0.188 green:0.494 blue:0.988 alpha:1];
        centerView.center = self.center;
        centerView.layer.cornerRadius = frame.size.height/2;
        centerView.layer.masksToBounds = true;
        [self addSubview:centerView];
    }
    
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [progressLayer stop];
    centerView.backgroundColor = [UIColor lightGrayColor];
}

- (void)start{
    [progressLayer start];
}

- (void)setConfirmAction:(void (^)())action{
    _confirm = action;
}

- (void)setCancelAction:(void (^)())action{
    _cancel = action;
}

- (void)progressLayer:(ProgressLayer*)layer didfinish:(BOOL)finish{
    if (finish) {
        _confirm?_confirm():nil;
    }else{
        _cancel?_cancel():nil;
    }
}

@end

@implementation CloseView
- (void)drawRect:(CGRect)rect{
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    
    //// Bezier Drawing
    UIBezierPath* bezierPath = UIBezierPath.bezierPath;
    [bezierPath moveToPoint:CGPointMake(rect.size.width/2-10,rect.size.height/2-10)];
    [bezierPath addLineToPoint:CGPointMake(rect.size.width/2+10,rect.size.height/2+10)];//右下へ
    [color setStroke];
    bezierPath.lineWidth = 3;
    [bezierPath stroke];
    
    //// Bezier 2 Drawing
    UIBezierPath* bezier2Path = UIBezierPath.bezierPath;
    [bezier2Path moveToPoint: CGPointMake(rect.size.width/2+10,rect.size.height/2-10)];
    [bezier2Path addLineToPoint:CGPointMake(rect.size.width/2-10,rect.size.height/2+10)];
    [color setStroke];
    bezier2Path.lineWidth = 3;
    [bezier2Path stroke];
}
@end