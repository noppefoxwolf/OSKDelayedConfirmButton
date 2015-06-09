//
//  progressLayer.h
//  OSKDelayedConfirmationAlertDemo
//
//  Created by Tomoya_Hirano on H27/06/10.
//  Copyright (c) 平成27年 Tomoya_Hirano. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@class ProgressLayer;

@protocol ProgressLayerDelegate <NSObject>
- (void)progressLayer:(ProgressLayer*)layer didfinish:(BOOL)finish;
@end

@interface ProgressLayer : CAShapeLayer
- (void)start;
- (void)stop;
@property (assign) id<ProgressLayerDelegate>completion_delegate;
@end
