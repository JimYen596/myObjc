//
//  AppError.h
//  YCCHttpHelper
//
//  Created by Jim.Yen on 2015/11/16.
//  Copyright © 2015年 Jim.Yen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppError : NSObject
@property (nonatomic, readwrite) NSInteger code;
@property (nonatomic, strong) NSString *message;
@end
