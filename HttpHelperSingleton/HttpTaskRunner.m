//
//  HttpTaskRunner.m
//  YCCHttpHelper
//
//  Created by Jim.Yen on 2015/11/16.
//  Copyright © 2015年 Jim.Yen. All rights reserved.
//

#import "HttpTaskRunner.h"
#import "SessionOperation.h"

@interface HttpTaskRunner()<NSURLSessionDataDelegate>
@end

@implementation HttpTaskRunner
{
    NSOperationQueue * _queue;
    NSURLSession *mySession;
}
static HttpTaskRunner *sharedInstance = nil;

- (id)init
{
    if ((self = [super init])) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        mySession = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        _queue = [[NSOperationQueue alloc]init];
        _queue.maxConcurrentOperationCount = 5;    //max concurrent queue
    }
    return self;
}

+ (HttpTaskRunner *)instance{
     static dispatch_once_t once;
     dispatch_once(&once, ^{
         if (nil == sharedInstance) {
             sharedInstance = [[HttpTaskRunner alloc] init];
         }
    });
     return sharedInstance;
}

- (BOOL)addTask:(AbstractTask *)task{
    
    for (AbstractTask *op in _queue.operations) {
        if ( [op isEqual:task]) {
            if (op.isExecuting) {
                NSLog(@"Find another task (%@) is executing now.", op.taskid);
                return NO;
            }
            NSLog(@"Find another task in queue, cancel it : %@", op.taskid);
            [op cancel];
            break;
        }
    }
    
    NSLog(@"Add task id->%@", task.taskid);
    [_queue addOperation:task];

    return YES;
}

- (BOOL)addRequest:(NSURLRequest*)request completionHandler:(void (^)(NSDictionary *result, NSError *error))completionHandler;
{
    SessionOperation *op = [[SessionOperation alloc]initWithSession:mySession request:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
         NSDictionary *resultDic = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        completionHandler(resultDic,error);
    }];
    
    for (SessionOperation *task in _queue.operations) {
        if ( [op isEqual:task]) {
            if (op.isExecuting) {
                NSLog(@"Find another task (%@) is executing now.", op.taskid);
                return NO;
            }
            NSLog(@"Find another task in queue, cancel it : %@", op.taskid);
            [op cancel];
            break;
        }
    }
    NSLog(@"Add task id->%@", op.taskid);
        
    [_queue addOperation:op];
    
    return YES;
}

- (BOOL)addUrl:(NSURL*)url completionHandler:(void (^)(NSData *data, NSError *error))completionHandler
{
    SessionOperation *op = [[SessionOperation alloc]initWithSession:mySession URL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        completionHandler(data,error);
    }];
    
    [_queue addOperation:op];
    
    return YES;
}

#pragma mark - queue management

- (void)stop {
    [self cancelAll];
}

- (void)pause {
    if (_queue.operationCount > 0)
        [_queue setSuspended:YES];
}

- (void)resume {
    [_queue setSuspended:NO];
}

-(void)cancelAll {
    [_queue cancelAllOperations];
    [_queue waitUntilAllOperationsAreFinished];
}

- (NSInteger)operationCount {
    return _queue.operationCount;
}

- (BOOL)hasOperation:(NSString *)tid {
    for (AbstractTask *t in _queue.operations) {
        if ( [t.taskid isEqualToString:tid ]) {
            return YES;
        }
    }
    return NO;
}

@end
