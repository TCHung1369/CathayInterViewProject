//
//  CustomNaviViewController.m
//  CathayInterViewProject
//
//  Created by Tzu_Chen on 20.02.21.
//  Copyright © 2021 Tzu-Chen. All rights reserved.
//

#import "CustomNaviViewController.h"

@interface CustomNaviViewController ()

@end

@implementation CustomNaviViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defaultSetting];
}

-(void)defaultSetting{
    //252 252 252
    [self.navigationBar setBarStyle:UIBarStyleDefault];
    [self.navigationBar setBarTintColor:[UIColor colorWithRed:252.0 / 255.0 green:252.0 / 255.0 blue:252.0 / 255.0 alpha:1.0]];
    [self.navigationBar setTranslucent:false];

}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];
}



@end
