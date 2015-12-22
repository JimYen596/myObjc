//
//  AbstractTask.h
//  YCCHttpHelper
//
//  Created by Jim.Yen on 2015/11/16.
//  Copyright © 2015年 Jim.Yen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppError.h"

#define DEFAULT_HTTP_TIMEOUT 20

@interface AbstractTask : NSOperation

@property (nonatomic, strong) NSString *taskid;
@property (nonatomic, strong) AppError *appError;

-(NSString *)toString;

- (id)initWithId:(NSString *)tid ;

-(void)postNotificationName:(NSString *)nName object:(id)obj;

-(void)tagAppError:(NSInteger)code withMessage:(NSString *)msg;

@end
