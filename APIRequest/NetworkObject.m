//
//  NetworkObject.m
//  CathayInterViewProject
//
//  Created by Tzu_Chen on 21.02.21.
//  Copyright © 2021 Tzu-Chen. All rights reserved.
//

#import "NetworkObject.h"

@implementation NetworkObject


+(instancetype)sharedInstance{
    static NetworkObject *networkObject = nil;
    if (networkObject == nil) {
        networkObject = [[NetworkObject alloc] init];
    }
    return networkObject;
}


-(void)fetchUserData{

    dispatch_semaphore_t sema = dispatch_semaphore_create(0);

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:USERDATA]
      cachePolicy:NSURLRequestUseProtocolCachePolicy
      timeoutInterval:10.0];

    [request setHTTPMethod:@"GET"];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
      if (error) {
        dispatch_semaphore_signal(sema);
      } else {
        NSError *parseError = nil;
        NSDictionary *userData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
        NSArray * users = [userData objectForKey:@"response"];
        NSDictionary * mainUser = [users firstObject];
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:[mainUser objectForKey:@"name"] forKey:@"name"];
        [userDefault setObject:[mainUser objectForKey:@"kokoid"] forKey:@"kokoid"];
          
        dispatch_semaphore_signal(sema);
      }
    }];
    [dataTask resume];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    
    
}

-(void)fetchNoFriendDataWithCompletion:(void (^)(BOOL isEmpty))completionBlock{
    
     dispatch_semaphore_t sema = dispatch_semaphore_create(0);

       NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:NOFRIEND]
         cachePolicy:NSURLRequestUseProtocolCachePolicy
         timeoutInterval:10.0];

       [request setHTTPMethod:@"GET"];

       NSURLSession *session = [NSURLSession sharedSession];
       NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
         if (error) {
           dispatch_semaphore_signal(sema);
         } else {
           NSError *parseError = nil;
           NSDictionary *friendData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
           NSArray * friends = [friendData objectForKey:@"response"];
           BOOL isEmpty;
             if ([friends count] == 0) {
                 isEmpty = true;
             } else {
                 isEmpty = false;
             }
        
           completionBlock(isEmpty);
           dispatch_semaphore_signal(sema);
         }
       }];
       [dataTask resume];
       dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
}

-(void)fetchFriendAndInviteDataWithCompletion:(void (^)(NSArray * friendArray,NSArray * invitingArray))completionBlock{

    NSArray * urls = @[FRIENDANDINVITION];
    NSMutableArray * friendsArray = [NSMutableArray array];
    NSMutableArray * invitingArray = [NSMutableArray array];
    dispatch_group_t group = dispatch_group_create();
    
    for (NSString * url in urls) {
        dispatch_group_enter(group);
        [self fetchFLDataWithURL:url WithCompletion:^(NSArray *friendArray) {
            [friendsArray addObject:friendArray];
            dispatch_group_leave(group);
        }];
        
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSMutableArray *flatArray = [NSMutableArray array];
        for (NSMutableArray * array  in friendsArray) {
            [flatArray addObjectsFromArray:array];
        }
        //Rearrange Array
        NSMutableIndexSet * indexSet = [[NSMutableIndexSet alloc] init];
        for (FriendModel * friend in flatArray) {
            NSString * fid = friend.fid;
            NSDate * date = friend.updateDate;
            for (FriendModel * compared in flatArray) {
                NSString * comparedFid = compared.fid;
                NSDate * comparedDate = compared.updateDate;
                if ([fid isEqualToString:comparedFid]) {
                    if (comparedDate > date) {
                        [indexSet addIndex:[flatArray indexOfObject:friend]];
                    }
                }
            }
        }
        [flatArray removeObjectsAtIndexes:indexSet];
        [flatArray sortUsingComparator:^NSComparisonResult(FriendModel* obj1, FriendModel* obj2) {
            return [obj2.updateDate compare:obj1.updateDate];
        }];
        [indexSet removeAllIndexes];
        //Separate who is inviting me
        for (FriendModel * friend in flatArray) {
            if ([friend.status  isEqual: @2]) {
                [invitingArray addObject:friend];
                [indexSet addIndex:[flatArray indexOfObject:friend]];
            }
        }
        [flatArray removeObjectsAtIndexes:indexSet];
        [indexSet removeAllIndexes];
        completionBlock(flatArray,invitingArray);
    });
    
}
//Fetch Multi-FriendList

-(void)fetchFLDataWithURL:(NSString *)url WithCompletion:(void (^)(NSArray *friendArray))completionBlock{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
            cachePolicy:NSURLRequestUseProtocolCachePolicy
            timeoutInterval:10.0];
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLSessionDataTask * dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *  data, NSURLResponse *  response, NSError *  error) {
        if (error) {
            NSLog(@"%@", [error localizedDescription]);
        }else{
            NSError *parseError = nil;
            NSDictionary *friendData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            NSArray * friends = [friendData objectForKey:@"response"];
            NSMutableArray * friendsMutableArray = [NSMutableArray array];
            
            for (NSDictionary * friendDic in friends) {
                FriendModel *friendModel = [[FriendModel alloc] init];
                friendModel.name = [friendDic objectForKey:@"name"];
                friendModel.fid = [friendDic objectForKey:@"fid"];
                friendModel.isTop = [ friendDic objectForKey:@"isTop"];
                friendModel.status = [friendDic objectForKey:@"status"];
                
                NSString * updateDate = [friendDic objectForKey:@"updateDate"];
                if ([updateDate  containsString:@"/"]) {
                    
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
                    NSDate *date = [dateFormatter dateFromString:updateDate];
                    friendModel.updateDate = date;
                    
                }else {
                    
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"yyyyMMdd"];
                    NSDate *date = [dateFormatter dateFromString:updateDate];
                    friendModel.updateDate = date;
                }
                
                [friendsMutableArray addObject:friendModel];
                
            }
            
            completionBlock(friendsMutableArray);
        }
    }];
    [dataTask resume];
}


-(void)fetchMultiFLDataWithCompletion:(void (^)(NSArray * friendArray))completionBlock{
    
    NSArray * urls = @[FRIENDLIST1,FRIENDLIST2];
    NSMutableArray * friendsArray = [NSMutableArray array];
    
    dispatch_group_t group = dispatch_group_create();
    
    for (NSString * url in urls) {
        dispatch_group_enter(group);
        [self fetchFLDataWithURL:url WithCompletion:^(NSArray *friendArray) {
            [friendsArray addObject:friendArray];
            dispatch_group_leave(group);
        }];
        
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSMutableArray *flatArray = [NSMutableArray array];
        for (NSMutableArray * array  in friendsArray) {
            [flatArray addObjectsFromArray:array];
        }
        NSLog(@"flatArray : %@",flatArray);
        //Rearrange Array
        NSMutableIndexSet * indexSet = [[NSMutableIndexSet alloc] init];
        for (FriendModel * friend in flatArray) {
            NSString * fid = friend.fid;
            NSDate * date = friend.updateDate;
            NSLog(@"Start Compare : %@, %@", fid,date);
            for (FriendModel * compared in flatArray) {
                NSString * comparedFid = compared.fid;
                NSDate * comparedDate = compared.updateDate;
                NSLog(@"Compared : %@, %@", comparedFid,comparedDate);
                if ([fid isEqualToString:comparedFid]) {
                    if (comparedDate > date) {
                        [indexSet addIndex:[flatArray indexOfObject:friend]];
                    }
                }
            }
        }
        [flatArray removeObjectsAtIndexes:indexSet];
        [flatArray sortUsingComparator:^NSComparisonResult(FriendModel* obj1, FriendModel* obj2) {
            return [obj2.updateDate compare:obj1.updateDate];
        }];
        
        completionBlock(flatArray);
    });
    
}

@end
