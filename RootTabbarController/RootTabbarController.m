//
//  RootTabbarController.m
//  CathayInterViewProject
//
//  Created by Tzu_Chen on 20.02.21.
//  Copyright © 2021 Tzu-Chen. All rights reserved.
//

#import "RootTabbarController.h"

@interface RootTabbarController ()

@end

@implementation RootTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    CustomTabBar * customTabbar = [[CustomTabBar alloc] init];
   
    [customTabbar setClickDelgate:self];
    [self setValue:customTabbar forKey:@"tabBar"];
    [self setRootTabbarController];
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self addCenterButtonWithImage:[UIImage imageNamed:@"icTabbarHomeOff"] highlightImage:[UIImage imageNamed:@"icTabbarHomeOff"]];
}
//RootTabBarControllerDelegate
-(void)tabBarButtonClick{
    NSLog(@"Press Button");
}

-(void)setRootTabbarController{
    //NSArray *imageArray = @[@"icTabbarProductsOff",@"icTabbarFriendsOn",@"icTabbarHomeOff",@"icTabbarManageOff",@"icTabbarSettingOff"];
    NSArray *imageArray = @[@"icTabbarProductsOff",@"icTabbarFriendsOn",@"icTabbarManageOff",@"icTabbarSettingOff"];
    int i = 0;
    for (i = 0; i < [imageArray count] ; i++) {
        
        if(i == 1) {
            SelectedViewController * vc = [[SelectedViewController alloc] initWithNibName:@"SelectedViewController" bundle:nil];
            CustomNaviViewController * navi = [[CustomNaviViewController alloc] initWithRootViewController:vc];
            [vc setTitle:@"起始畫面"];
            UIImage * image01 = [UIImage imageNamed:imageArray[i]];
            UITabBarItem *barItem = [[UITabBarItem alloc] initWithTitle:@"" image:image01 selectedImage:image01];
            [vc setTabBarItem:barItem];
            [self addChildViewController:navi];
        }else{
        
        
        UIViewController * viewController = [[UIViewController alloc] init];
        CustomNaviViewController * navi = [[CustomNaviViewController alloc] initWithRootViewController:viewController];
        UIImage * image01 = [UIImage imageNamed:imageArray[i]];
        UITabBarItem *barItem = [[UITabBarItem alloc] initWithTitle:@"" image:image01 selectedImage:image01];
        [viewController setTabBarItem:barItem];
        [self addChildViewController:navi];
        }
    }
}

-(void) addCenterButtonWithImage:(UIImage*)buttonImage highlightImage:(UIImage*)highlightImage
{
  UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
  button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
  button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
  [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
  [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];

  CGFloat heightDifference = buttonImage.size.height - self.tabBar.frame.size.height;
  if (heightDifference < 0)
    button.center = self.tabBar.center;
  else
  {
    CGPoint center = self.tabBar.center;
    center.y = center.y - heightDifference/2.0;
    button.center = center;
  }
  
  [self.view addSubview:button];
}


@end
