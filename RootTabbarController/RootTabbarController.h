//
//  RootTabbarController.h
//  CathayInterViewProject
//
//  Created by Tzu_Chen on 20.02.21.
//  Copyright © 2021 Tzu-Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTabBar.h"
#import "CustomNaviViewController.h"
#import "SelectedViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface RootTabbarController : UITabBarController <RootTabBarControllerDelegate>
-(void) addCenterButtonWithImage:(UIImage*)buttonImage highlightImage:(UIImage*)highlightImage;
@end

NS_ASSUME_NONNULL_END
