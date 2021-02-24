//
//  InvitingCollectionViewCell.m
//  CathayInterViewProject
//
//  Created by Tzu_Chen on 23.02.21.
//  Copyright © 2021 Tzu-Chen. All rights reserved.
//

#import "InvitingCollectionViewCell.h"

@implementation InvitingCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self roundCornerView:self.selfieImageView];
    [self roundCornerView:self.acceptButton];
    [self roundCornerView:self.deleteButton];
    [self settingCellButtonOutfit:self.containerView];

}
-(void)roundCornerView:(UIView *)view{
    
    CGRect viewRect = view.frame;
    [view.layer setCornerRadius:viewRect.size.height / 2];
    [view.layer setMasksToBounds:true];
}

-(void)settingCellButtonOutfit:(UIView *)containerView{
   
    [containerView.layer setShadowColor:[UIColor blackColor].CGColor ];
    [containerView.layer setCornerRadius:6];
    [containerView.layer setShadowOffset:CGSizeMake(0, 4)];
    [containerView.layer setShadowOpacity:0.1];
    [containerView.layer setShadowRadius:8];
    
}
@end
