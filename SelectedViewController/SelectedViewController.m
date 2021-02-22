//
//  SelectedViewController.m
//  CathayInterViewProject
//
//  Created by Tzu_Chen on 21.02.21.
//  Copyright © 2021 Tzu-Chen. All rights reserved.
//

#import "SelectedViewController.h"
#import "WithoutFriendsViewController.h"
#import "FriendViewController.h"

@interface SelectedViewController ()

@end

@implementation SelectedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self DefaultSetting];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.indicator setHidesWhenStopped:true];
    [self.indicator stopAnimating];
    [self.navigationController.navigationBar setHidden:false];
}

-(void)DefaultSetting{
    [self roundCornerView:self.withoutFriendButton];
    [self roundCornerView:self.FLIncludeInvition];
    [self roundCornerView:self.FLWithoutInvition];
}

//RoundCorner Method
-(void)roundCornerView:(UIView *)view{
    
    CGRect viewRect = view.frame;
    [view.layer setCornerRadius:viewRect.size.height / 2];
    [view.layer setMasksToBounds:true];
}

- (IBAction)withoutFLVC:(id)sender {
    
    [self.indicator startAnimating];
    
    [[NetworkObject sharedInstance] fetchNoFriendDataWithCompletion:^(BOOL isEmpty) {
        if(isEmpty == true){
        
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.indicator stopAnimating];
                WithoutFriendsViewController *vc = [[WithoutFriendsViewController alloc] initWithNibName:@"WithoutFriendsViewController" bundle:nil];
                [self.navigationController pushViewController:vc animated:true];
            });
             
        }
    }];
}

- (IBAction)FLVC:(id)sender{
    
    
    [[NetworkObject sharedInstance] fetchMultiFLDataWithCompletion:^(NSArray *friendArray) {
        
        NSLog(@"Fetch Result : %@",friendArray);
        
        if ([friendArray count] == 0) {
            return;;
        }else {
            FriendViewController *vc = [[FriendViewController alloc] initWithNibName:@"FriendViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:true];
        }
    }];
    
    
    
}
@end
