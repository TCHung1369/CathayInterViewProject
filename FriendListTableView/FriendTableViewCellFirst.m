//
//  FriendTableViewCellFirst.m
//  CathayInterViewProject
//
//  Created by Tzu_Chen on 22.02.21.
//  Copyright © 2021 Tzu-Chen. All rights reserved.
//

#import "FriendTableViewCellFirst.h"

@implementation FriendTableViewCellFirst

- (void)awakeFromNib {
    [super awakeFromNib];
    [self roundCornerView:self.selfieimageView];
    [self settingCellButtonOutfit:self.inviteButton];
    [self settingCellButtonOutfit:self.transferButton];
    
}


-(void)settingCellButtonOutfit:(UIButton *)button{
    [button.layer setBorderWidth:1.2];
    [button.layer setCornerRadius:2];
    [button.layer setMasksToBounds:true];
    [button.layer setBorderColor:[button.titleLabel.textColor CGColor]];
}

-(void)roundCornerView:(UIView *)view{
    
    CGRect viewRect = view.frame;
    [view.layer setCornerRadius:viewRect.size.height / 2];
    [view.layer setMasksToBounds:true];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)prepareForReuse{
    [super prepareForReuse];
    [self.starImageView setHidden:true];
}

@end
