//
//  HttpTaskRunner.h
//  YCCHttpHelper
//
//  Created by Jim.Yen on 2015/11/16.
//  Copyright © 2015年 Jim.Yen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractTask.h"

@interface HttpTaskRunner : NSObject

+(HttpTaskRunner *)instance;

- (BOOL)addTask:(AbstractTask *)task;

- (BOOL)addRequest:(NSURLRequest*)request completionHandler:(void (^)(NSDictionary *result, NSError *error))completionHandler;

- (BOOL)addUrl:(NSURL*)url completionHandler:(void (^)(NSData *data, NSError *error))completionHandler;

- (void)stop;

- (void)pause;

- (void)resume;

- (void)cancelAll;

- (NSInteger)operationCount;

- (BOOL)hasOperation:(NSString *)tid;

@end
