//
//  InvitingViewController.h
//  CathayInterViewProject
//
//  Created by Tzu_Chen on 23.02.21.
//  Copyright © 2021 Tzu-Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendTableViewCellFirst.h"
#import "FriendTableViewCellSecond.h"
#import "FriendModel.h"
#import "NetworkObject.h"
#import "InvitingCollectionViewCell.h"
#import "OverlayCVFlowLayout.h"
NS_ASSUME_NONNULL_BEGIN

@interface InvitingViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
-(id)initWithNibName:(NSString *)nibNameOrNil dataSource:(NSArray *)dataSource andInvitingData:(NSArray *)invitingData bundle:(NSBundle *)nibBundleOrNil;
@end

NS_ASSUME_NONNULL_END
