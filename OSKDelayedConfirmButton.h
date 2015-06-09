//
//  OSKDelayedConfirmButton.h
//  OSKDelayedConfirmationAlertDemo
//
//  Created by Tomoya_Hirano on H27/06/10.
//  Copyright (c) 平成27年 Tomoya_Hirano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OSKDelayedConfirmButton : UIView
- (void)start;
- (void)setConfirmAction:(void(^)())action;
- (void)setCancelAction:(void(^)())action;
@end
