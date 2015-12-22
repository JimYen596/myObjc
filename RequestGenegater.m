//
//  RequestGenegater.m
//  YCCHttpHelper
//
//  Created by Jim.Yen on 2015/12/22.
//  Copyright © 2015年 Jim.Yen. All rights reserved.
//

#import "RequestGenegater.h"

@implementation RequestGenegater
+(NSURLRequest*)requestFromURL:(NSString*)urlString withMethod:(HttpMethods)httpMethod parameters:(NSDictionary*)params
{
    if(httpMethod == POST){
        
        if(params != nil){
            
            NSMutableString *bodyString = [[NSMutableString alloc]init];
            
            int count = 0;
            
            for (NSString *key in params.allKeys) {
                if (count > 0)
                    [bodyString appendString:@"&"];
                [bodyString appendString:[NSString stringWithFormat:@"%@=%@", key, [params objectForKey:key]]];
                count ++;
            }
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:urlString] cachePolicy:0 timeoutInterval:15.0];
            
            [request setHTTPMethod:@"POST"];
            [request setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
            
            return request;
        }
        
    }else if (httpMethod == GET){
        
        if(params != nil){
            
            NSMutableString *url = [[NSMutableString alloc]initWithString:urlString];
            int count = 0;
            for (NSString *key in params.allKeys) {
                if (count > 0)
                    [url appendString:@"&"];
                else
                    [url appendString:@"?"];
                
                [url appendString:[NSString stringWithFormat:@"%@=%@", key, [params objectForKey:key]]];
                count ++;
            }

            NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:[url stringByAddingPercentEncodingWithAllowedCharacters:set]] cachePolicy:0 timeoutInterval:15.0];
            [request setHTTPMethod:@"GET"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            
            return request;
        }
    }
    
    return nil;
}

@end
