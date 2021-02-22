//
//  FriendModel.h
//  CathayInterViewProject
//
//  Created by Tzu_Chen on 21.02.21.
//  Copyright © 2021 Tzu-Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendModel : NSObject
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) int status;
@property (nonatomic, strong) NSString *isTop;
@property (nonatomic, strong) NSString *fid;
@property (nonatomic, strong) NSDate *updateDate;

-(instancetype)initWithName:(NSString*)name andStatus:(int)status andTop:(NSString *)isTop andFid:(NSString *)fid andUpdateDate:(NSDate *)updateDate;

@end

