//
//  RunscopeURLRequest.h
//
/*The MIT License
 
 Copyright (c) 2013 Hung Truong http://www.hung-truong.com
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

#import <Foundation/Foundation.h>

@interface RunscopeURLRequest : NSMutableURLRequest

@property (nonatomic, strong) NSString *bucketID;
+(id)requestWithURL:(NSURL *)URL bucket:(NSString *)bucketID;
+(id)requestWithURL:(NSURL *)URL bucket:(NSString *)bucketID auth_token:(NSString *)auth_token;
+(id)requestWithURL:(NSURL *)URL cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeoutInterval bucket:(NSString *)bucketID;
+(id)requestWithURL:(NSURL *)URL cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeoutInterval bucket:(NSString *)bucketID auth_token:(NSString *)auth_token;

+(NSURL *)runscopeURLFromURL:(NSURL *)URL bucket:(NSString *)bucketID;

-(id)initWithURL:(NSURL *)URL bucket:(NSString *)bucketID;
-(id)initWithURL:(NSURL *)URL bucket:(NSString *)bucketID auth_token:(NSString *)auth_token;

-(id)initWithURL:(NSURL *)URL cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeoutInterval bucket:(NSString *)bucketID;
-(id)initWithURL:(NSURL *)URL cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeoutInterval bucket:(NSString *)bucketID auth_token:(NSString *)auth_token;

-(void)setURL:(NSURL *)URL bucket:(NSString *)bucketID;
-(void)setRequestPortForURL:(NSURL *)URL;
-(void)setRequestAuthToken:(NSString *)auth_token;
@end