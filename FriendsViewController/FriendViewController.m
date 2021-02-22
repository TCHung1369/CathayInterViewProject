//
//  FriendViewController.m
//  CathayInterViewProject
//
//  Created by Tzu_Chen on 21.02.21.
//  Copyright © 2021 Tzu-Chen. All rights reserved.
//

#import "FriendViewController.h"

@interface FriendViewController ()
@property (weak, nonatomic) IBOutlet UIButton *atmButton;
@property (weak, nonatomic) IBOutlet UIButton *transferButton;
@property (weak, nonatomic) IBOutlet UIButton *scanButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *settingIDLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (weak, nonatomic) IBOutlet UIImageView *selfieImageView;
@property (weak, nonatomic) IBOutlet UIButton *myFriendButton;
@property (weak, nonatomic) IBOutlet UIButton *chatButton;
@property (weak, nonatomic) IBOutlet UIView *indicatorView;
@property (weak, nonatomic) IBOutlet UILabel *chatBadge;
@property (nonatomic, strong) NSArray * dataSource;
@end

@implementation FriendViewController

-(id)initWithNibName:(NSString *)nibNameOrNil dataSource:(NSArray *)dataSource bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.dataSource = dataSource;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:true];
    [self DefaultSetting];
}

-(void)DefaultSetting{
    [self roundCornerView:self.selfieImageView];
    [self roundCornerView:self.indicatorView];
    [self roundCornerView:self.chatBadge];
    
    //KOKO ID：olylinhuang
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"name"] != nil) {
        [self.nameLabel setText:[[NSUserDefaults standardUserDefaults] objectForKey:@"name"]];
        [self.settingIDLabel setText:[NSString stringWithFormat:@"KOKO ID：%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"kokoid"]]];
    }else{
        [self.nameLabel setText:@"Default User"];
        [self.settingIDLabel setText:[NSString stringWithFormat:@"KOKO ID：olylinhuang"]];
    }
}


-(void)roundCornerView:(UIView *)view{
    
    CGRect viewRect = view.frame;
    [view.layer setCornerRadius:viewRect.size.height / 2];
    [view.layer setMasksToBounds:true];
}


- (IBAction)atmMethod:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
    
}
@end
