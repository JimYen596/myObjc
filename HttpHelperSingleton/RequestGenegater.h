//
//  RequestGenegater.h
//  YCCHttpHelper
//
//  Created by Jim.Yen on 2015/12/22.
//  Copyright © 2015年 Jim.Yen. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum HttpMethods {
    GET,
    POST,
} HttpMethods;
@interface RequestGenegater : NSObject
+(NSURLRequest*)requestFromURL:(NSString*)urlString withMethod:(HttpMethods)httpMethod parameters:(NSDictionary*)params;
@end
