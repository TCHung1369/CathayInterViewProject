//
//  FriendViewController.h
//  CathayInterViewProject
//
//  Created by Tzu_Chen on 21.02.21.
//  Copyright © 2021 Tzu-Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendTableViewCellFirst.h"
#import "FriendTableViewCellSecond.h"
#import "FriendModel.h"
#import "NetworkObject.h"
@interface FriendViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
-(id)initWithNibName:(NSString *)nibNameOrNil dataSource:(NSArray *)dataSource bundle:(NSBundle *)nibBundleOrNil;
@end


