//
//  CustomTabBar.m
//  CathayInterViewProject
//
//  Created by Tzu_Chen on 20.02.21.
//  Copyright © 2021 Tzu-Chen. All rights reserved.
//

#import "CustomTabBar.h"

@implementation CustomTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTintColor:[UIColor colorWithRed:236.0/255.0 green:0.0 blue:140.0/255.0 alpha:1.0]];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setBackgroundImage:[UIImage imageNamed:@"imgTabbarBg"]];
        [self setClipsToBounds:true];
    }
    return self;
}


//Delegate click
-(void)KOButtonClick {
    if (_clickDelgate != nil) {
        [_clickDelgate tabBarButtonClick];
    }else {
        NSLog(@"_clickDelgate is nil");
    }
}


-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat barButtonWidth = self.frame.size.width / 5;
    int barButtonIndex = 0;
        //KOButton
       
    for (UIView * barButton in [self subviews]) {
        if ([barButton isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            if(barButtonIndex == 2){
                barButtonIndex += 1;
            }
            [barButton setFrame:CGRectMake(barButtonWidth * barButtonIndex, 11, barButtonWidth, self.frame.size.height)];
                barButtonIndex += 1;
            
        }
    }
    
    [self bringSubviewToFront:self.KOButton];
}

-(CGSize)sizeThatFits:(CGSize)size
{
    CGSize sizeThatFits = [super sizeThatFits:size];
    sizeThatFits.height = 68;

    return sizeThatFits;
}

@end
