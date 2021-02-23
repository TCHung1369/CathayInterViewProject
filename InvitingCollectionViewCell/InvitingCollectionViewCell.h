//
//  InvitingCollectionViewCell.h
//  CathayInterViewProject
//
//  Created by Tzu_Chen on 23.02.21.
//  Copyright © 2021 Tzu-Chen. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface InvitingCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *selfieImageView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *desciption;
@property (weak, nonatomic) IBOutlet UIButton *acceptButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end


