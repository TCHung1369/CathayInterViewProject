//
//  CustomTabBar.h
//  CathayInterViewProject
//
//  Created by Tzu_Chen on 20.02.21.
//  Copyright © 2021 Tzu-Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RootTabBarControllerDelegate

-(void)tabBarButtonClick;

@end

@interface CustomTabBar : UITabBar<RootTabBarControllerDelegate>

@property (nonatomic, weak) id <RootTabBarControllerDelegate> clickDelgate;
@property (nonatomic, strong) UIButton *KOButton;

@end


