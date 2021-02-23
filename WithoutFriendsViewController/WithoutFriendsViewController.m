//
//  WithoutFriendsViewController.m
//  CathayInterViewProject
//
//  Created by Tzu_Chen on 21.02.21.
//  Copyright © 2021 Tzu-Chen. All rights reserved.
//

#import "WithoutFriendsViewController.h"

@interface WithoutFriendsViewController ()
@property (weak, nonatomic) IBOutlet UIButton *atmButton;
@property (weak, nonatomic) IBOutlet UIButton *transferButton;
@property (weak, nonatomic) IBOutlet UIButton *scanButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *settingIDLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (weak, nonatomic) IBOutlet UIView *statusView;
@property (weak, nonatomic) IBOutlet UIImageView *selfieImageView;
@property (weak, nonatomic) IBOutlet UIButton *myFriendButton;
@property (weak, nonatomic) IBOutlet UIButton *chatButton;
@property (weak, nonatomic) IBOutlet UIView *indicatorView;
@property (weak, nonatomic) IBOutlet UIView *addFriendBacground;
@property (weak, nonatomic) IBOutlet UIView *helpBackground;
@property (weak, nonatomic) IBOutlet UIButton *addFriendButton;
@property (weak, nonatomic) IBOutlet UIImageView *addFriendImageView;

@end

@implementation WithoutFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:true];
    

}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self DefaultSetting];
}

-(void)DefaultSetting{
    [self roundCornerView:self.selfieImageView];
    [self roundCornerView:self.indicatorView];
    [self roundCornerView:self.statusView];
    [self roundCornerView:self.addFriendBacground];
    
    //Setting GradientLayer
    CAGradientLayer * gradientLayer = [[CAGradientLayer alloc] init];
    [gradientLayer setFrame:self.addFriendBacground.bounds];
    UIColor * frogGreen = [UIColor colorWithRed:86.0/255.0 green:179.0/255.0 blue:11.0/255.0 alpha:1.0] ;
    UIColor * lightOliveGreen = [UIColor colorWithRed:166.0/255.0 green:204.0/255.0 blue:66.0/255.0 alpha:1.0];
    [gradientLayer setColors:@[(__bridge id)frogGreen.CGColor, (__bridge id)lightOliveGreen.CGColor]];
    [gradientLayer setStartPoint:CGPointMake(0, 0.5)];
    [gradientLayer setEndPoint:CGPointMake(1, 0.5)];
    [self.addFriendBacground.layer addSublayer:gradientLayer];
    [self.addFriendBacground bringSubviewToFront:self.addFriendButton];
    [self.addFriendBacground bringSubviewToFront:self.addFriendImageView];
    
    //Setting UI text
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"name"] != nil) {
        [self.nameLabel setText:[[NSUserDefaults standardUserDefaults] objectForKey:@"name"]];
    }else{
        [self.nameLabel setText:@"Default User"];
    }
}

//RoundCorner Method
-(void)roundCornerView:(UIView *)view{
    
    CGRect viewRect = view.frame;
    [view.layer setCornerRadius:viewRect.size.height / 2];
    [view.layer setMasksToBounds:true];
}


#pragma Mark:- Button Method

- (IBAction)atmMethod:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
    
}
- (IBAction)transferMethod:(id)sender {
}
- (IBAction)scanMethod:(id)sender {
}

@end
