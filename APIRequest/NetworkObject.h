//
//  NetworkObject.h
//  CathayInterViewProject
//
//  Created by Tzu_Chen on 21.02.21.
//  Copyright © 2021 Tzu-Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FriendModel.h"

//Define API URL
#define USERDATA @"https://dimanyen.github.io/man.json"
#define FRIENDLIST1 @"https://dimanyen.github.io/friend1.json"
#define FRIENDLIST2 @"https://dimanyen.github.io/friend2.json"
#define FRIENDANDINVITION @"https://dimanyen.github.io/friend3.json"
#define NOFRIEND @"https://dimanyen.github.io/friend4.json"

@interface NetworkObject : NSObject
+(instancetype)sharedInstance;
-(void)fetchUserData;
-(void)fetchNoFriendDataWithCompletion:(void (^)(BOOL isEmpty))completionBlock;
@end

