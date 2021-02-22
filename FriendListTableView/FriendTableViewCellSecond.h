//
//  FriendTableViewCellSecond.h
//  CathayInterViewProject
//
//  Created by Tzu_Chen on 22.02.21.
//  Copyright © 2021 Tzu-Chen. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FriendTableViewCellSecond : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerView;
@property (weak, nonatomic) IBOutlet UIImageView *starImageView;
@property (weak, nonatomic) IBOutlet UIImageView *selfieimageView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIButton *transferButton;
@property (weak, nonatomic) IBOutlet UIImageView *moreImageView;
@end


