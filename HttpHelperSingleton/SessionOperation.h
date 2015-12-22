//
//  SessionOperation.h
//  YCCHttpHelper
//
//  Created by Jim.Yen on 2015/11/23.
//  Copyright © 2015年 Jim.Yen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractTask.h"

@interface SessionOperation : AbstractTask

@property (nonatomic, strong, readonly) NSURLSessionDataTask *task;

- (instancetype)initWithSession:(NSURLSession *)session URL:(NSURL *)url completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler;
- (instancetype)initWithSession:(NSURLSession *)session request:(NSURLRequest *)request completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler;

@end
