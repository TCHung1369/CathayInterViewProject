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
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UITableView *friendTableView;


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
    
    //Setting UITableViewCell
    [self.friendTableView registerNib:[UINib nibWithNibName:@"FriendTableViewCellFirst" bundle:nil] forCellReuseIdentifier:@"FirstCell"];
    
    [self.friendTableView registerNib:[UINib nibWithNibName:@"FriendTableViewCellSecond" bundle:nil] forCellReuseIdentifier:@"SecondCell"];
    
}


-(void)roundCornerView:(UIView *)view{
    
    CGRect viewRect = view.frame;
    [view.layer setCornerRadius:viewRect.size.height / 2];
    [view.layer setMasksToBounds:true];
}


- (IBAction)atmMethod:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //status : 0 (邀請已送出) First , 1 : 可轉帳 Second
    FriendModel *friend = [self.dataSource objectAtIndex:indexPath.row];
    NSLog(@"%@",friend.status);
    if ([friend.status isEqualToNumber:@0] ) {
         FriendTableViewCellFirst * cellFirst = [tableView dequeueReusableCellWithIdentifier:@"FirstCell"];
           
           
           if ([friend.isTop isEqualToString:@"1"]) {
               //有星星
               [cellFirst.starImageView setHidden:false];
           }else{
               [cellFirst.starImageView setHidden:true];
           }
           cellFirst.name.text = friend.name;
           
           return cellFirst;
    }else {
        FriendTableViewCellSecond * cellSecond = [tableView dequeueReusableCellWithIdentifier:@"SecondCell"];
                  
                  
                  if ([friend.isTop isEqualToString:@"1"]) {
                      //有星星
                      [cellSecond.starImageView setHidden:false];
                  }else{
                      [cellSecond.starImageView setHidden:true];
                  }
                  cellSecond.name.text = friend.name;
                  
                  return cellSecond;
    
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


@end
