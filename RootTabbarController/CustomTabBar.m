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
//        self.KOButton = [UIButton buttonWithType:UIButtonTypeCustom];
//
//        [self.KOButton setBackgroundImage:[UIImage imageNamed:@"icTabbarHomeOff"] forState:UIControlStateNormal];
//
//        [self.KOButton addTarget:self action:@selector(KOButtonClick) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:self.KOButton];
        //rgb 236 0 140
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
//                [self.KOButton setFrame:CGRectMake(0.0, 0.0, self.KOButton.currentImage.size.width, self.KOButton.currentImage.size.height)];
//                [self.KOButton setCenter:CGPointMake(self.center.x, 34)];
                barButtonIndex += 1;
            }
            [barButton setFrame:CGRectMake(barButtonWidth * barButtonIndex, 11, barButtonWidth, self.frame.size.height)];
                barButtonIndex += 1;
            
        }
    }
    
    [self bringSubviewToFront:self.KOButton];
}

//-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//
//    if (self.isHidden) {
//        return [super hitTest:point withEvent:event];
//    }else {
//        CGPoint onButton = [self convertPoint:point toView:self.KOButton];
//        if ([self.KOButton pointInside:onButton withEvent:event]) {
//            return self.KOButton;
//        }else{
//            return [super hitTest:point withEvent:event];
//        }
//
//    }
//
//
//}


-(CGSize)sizeThatFits:(CGSize)size
{
    CGSize sizeThatFits = [super sizeThatFits:size];
    sizeThatFits.height = 68;

    return sizeThatFits;
}

@end
