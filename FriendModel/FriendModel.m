//
//  FriendModel.m
//  CathayInterViewProject
//
//  Created by Tzu_Chen on 21.02.21.
//  Copyright © 2021 Tzu-Chen. All rights reserved.
//

#import "FriendModel.h"

@implementation FriendModel

-(instancetype)initWithName:(NSString*)name andStatus:(int)status andTop:(NSString *)isTop andFid:(NSString *)fid andUpdateDate:(NSString *)updateDate{
    
    self = [super init];
    if (self) {
        self.name = name;
        self.status = status;
        self.isTop = isTop;
        self.fid = fid;
        self.updateDate = updateDate;
    }
    return self;
}

@end
