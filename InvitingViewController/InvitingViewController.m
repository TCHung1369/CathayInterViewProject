//
//  InvitingViewController.m
//  CathayInterViewProject
//
//  Created by Tzu_Chen on 23.02.21.
//  Copyright © 2021 Tzu-Chen. All rights reserved.
//

#import "InvitingViewController.h"

@interface InvitingViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *switchContainerView;
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
@property (weak, nonatomic) IBOutlet UILabel *friendBadge;
@property (nonatomic, strong) NSArray * dataSource;
@property (nonatomic, strong) NSMutableArray * searchDataSource;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UITableView *friendTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (assign,nonatomic) BOOL isSearchMode;
@property (nonatomic, strong) UIRefreshControl * refreshControl;
@property (nonatomic, strong) UICollectionView *friendCollectionView;

@property (assign, nonatomic)CGFloat deltaPosition;
@property (assign, nonatomic)CGRect searchBarOriginRect;
@property (assign, nonatomic)CGRect tableViewOriginRect;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchViewTopConstraint;

@end

@implementation InvitingViewController


-(id)initWithNibName:(NSString *)nibNameOrNil dataSource:(NSArray *)dataSource bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.dataSource = dataSource;
        self.searchDataSource = [dataSource mutableCopy];
        self.isSearchMode = false;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:true];
    [self DefaultSetting];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.deltaPosition = self.view.frame.size.height - self.searchView.frame.size.height - self.friendTableView.frame.size.height + 68 - 44;
    NSLog(@"self.deltaPosition : %f",self.deltaPosition);
}


-(void)DefaultSetting{
    [self roundCornerView:self.selfieImageView];
    [self roundCornerView:self.indicatorView];
    [self roundCornerView:self.chatBadge];
    [self roundCornerView:self.friendBadge];
    //KOKO ID：olylinhuang
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"name"] != nil) {
        [self.nameLabel setText:[[NSUserDefaults standardUserDefaults] objectForKey:@"name"]];
        [self.settingIDLabel setText:[NSString stringWithFormat:@"KOKO ID：%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"kokoid"]]];
    }else{
        [self.nameLabel setText:@"Default User"];
        [self.settingIDLabel setText:[NSString stringWithFormat:@"KOKO ID：olylinhuang"]];
    }
    
    //Add UIRefreshControl
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl setAttributedTitle:[[NSAttributedString alloc]initWithString:@"列表更新中..."]];
    [self.refreshControl addTarget:self action:@selector(reloadData) forControlEvents:UIControlEventValueChanged];
    //Setting UITableViewCell
    [self.friendTableView registerNib:[UINib nibWithNibName:@"FriendTableViewCellFirst" bundle:nil] forCellReuseIdentifier:@"FirstCell"];
    
    [self.friendTableView registerNib:[UINib nibWithNibName:@"FriendTableViewCellSecond" bundle:nil] forCellReuseIdentifier:@"SecondCell"];
    [self.friendTableView addSubview:self.refreshControl];
}


-(void)roundCornerView:(UIView *)view{
    
    CGRect viewRect = view.frame;
    [view.layer setCornerRadius:viewRect.size.height / 2];
    [view.layer setMasksToBounds:true];
}


- (IBAction)atmMethod:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
    
}

-(void)reloadData{
    
    [[NetworkObject sharedInstance] fetchMultiFLDataWithCompletion:^(NSArray *friendArray) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.refreshControl endRefreshing];
            self.dataSource = friendArray;
            [self.friendTableView reloadData];
            
        });
        
    }];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.isSearchMode == false) {
         return [self.dataSource count];
    }else{
        return [self.searchDataSource count];
    }
    
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //status : 0 (邀請已送出) First , 1 : 可轉帳 Second
    FriendModel *friend;
    if (self.isSearchMode == true) {
        friend = [self.searchDataSource objectAtIndex:indexPath.row];
    }else{
        friend = [self.dataSource objectAtIndex:indexPath.row];
    }
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

//UIsearchBar Delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    self.isSearchMode = true;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.searchViewTopConstraint.constant = -312;
        [self.view layoutIfNeeded];

    }];
    
    [self.friendTableView reloadData];
    return true;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self.searchDataSource removeAllObjects];
    for (FriendModel *friend in self.dataSource) {
        
        if ([friend.name containsString:searchText]) {
            [self.searchDataSource addObject:friend];
        }
    }
    if ([searchText isEqualToString:@""]) {
        [self.searchDataSource removeAllObjects];
        self.searchDataSource = [self.dataSource mutableCopy];
        
    }
    [self.friendTableView reloadData];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.isSearchMode = false;
    searchBar.text = @"";
    [searchBar resignFirstResponder];
    [UIView animateWithDuration:0.5 animations:^{
        self.searchViewTopConstraint.constant = 0;
       [self.view layoutIfNeeded];
    }];
    [self.searchDataSource removeAllObjects];
    self.searchDataSource = [self.dataSource mutableCopy];
    [self.friendTableView reloadData];
}

@end
