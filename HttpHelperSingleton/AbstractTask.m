//
//  AbstractTask.m
//  YCCHttpHelper
//
//  Created by Jim.Yen on 2015/11/16.
//  Copyright © 2015年 Jim.Yen. All rights reserved.
//

#import "AbstractTask.h"

@implementation AbstractTask
{
    NSString * _taskid;
}

@synthesize taskid = _taskid;
@synthesize appError;

NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

-(NSString *) randomStringWithLength: (int) len {
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform( (int)[letters length]) % [letters length]]];
    }
    
    return randomString;
}

- (id)init {
    if (self = [super init]) {
        self.taskid = [self randomStringWithLength:16];
    }
    return self;
}

- (id)initWithId:(NSString *)tid {
    if (self = [super init]) {
        if (tid!=nil) {
            self.taskid = tid;
        } else {
            self.taskid = [self randomStringWithLength:16];
        }
    }
    return self;
}

- (void)tagAppError:(NSInteger)code withMessage:(NSString *)msg {
    if(!self.appError){
        self.appError = [AppError new];
    }
    self.appError.code = code;
    self.appError.message = msg;
}

- (void)postNotificationName:(NSString *)nName object:(id)obj {
    dispatch_async(dispatch_get_main_queue(),^{
        [[NSNotificationCenter defaultCenter] postNotificationName:nName object:obj];
    });
}

-(NSString *)toString {

    return _taskid;
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![other isKindOfClass:[self class]])
        return NO;
    
    return [_taskid isEqualToString:((AbstractTask*)other).taskid];
}

@end
