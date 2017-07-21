//
//  ShareController.h
//  Yuanqu
//
//  Created by 李龙 on 2017/7/20.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <VVBlurViewController.h>

@class ShareController;

//----通知RecipeDetailBoard_iPhone去dismiss当前VC
@protocol ShareDismissDelegate <NSObject>
-(void)didDismissKYShareVC:(ShareController *)viewController;
@end

@interface ShareController : VVBlurViewController

@property(nonatomic,weak)id<ShareDismissDelegate> delegate;

@end
