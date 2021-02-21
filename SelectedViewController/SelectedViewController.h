//
//  SelectedViewController.h
//  CathayInterViewProject
//
//  Created by Tzu_Chen on 21.02.21.
//  Copyright © 2021 Tzu-Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkObject.h"
NS_ASSUME_NONNULL_BEGIN

@interface SelectedViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *withoutFriendButton;
@property (weak, nonatomic) IBOutlet UIButton *FLWithoutInvition;
@property (weak, nonatomic) IBOutlet UIButton *FLIncludeInvition;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;


@end

NS_ASSUME_NONNULL_END
