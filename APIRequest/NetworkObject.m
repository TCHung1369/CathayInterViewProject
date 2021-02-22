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
        NSLog(@"%@",mainUser);
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
            completionBlock(friends);
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
            NSLog(@"url:%@ ,friendArray : %@",url, friendArray);
            [friendsArray addObject:friendArray];
            dispatch_group_leave(group);
        }];
        
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        completionBlock(friendsArray);
    });
    
    
//    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
//    NSLog(@"friendsArray  : %@",friendsArray );
//    completionBlock(friendsArray);
    
}

@end
