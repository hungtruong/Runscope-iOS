//
//  RunscopeURLRequest.m
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

#import "RunscopeURLRequest.h"

@implementation RunscopeURLRequest

-(id)initWithURL:(NSURL *)URL bucket:(NSString *)bucketID {
  return [self initWithURL:URL bucket:bucketID auth_token:nil];
}

-(id)initWithURL:(NSURL *)URL bucket:(NSString *)bucketID auth_token:(NSString *)auth_token {
  NSURL *newURL = [RunscopeURLRequest runscopeURLFromURL:URL bucket:bucketID];
  self = [super initWithURL:newURL];
  [self setRequestPortForURL:URL];
  if (auth_token){
    [self setRequestAuthToken:auth_token];
  }
  return self;
}

-(id)initWithURL:(NSURL *)URL cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeoutInterval bucket:(NSString *)bucketID {
  return [self initWithURL:URL cachePolicy:cachePolicy timeoutInterval:timeoutInterval bucket:bucketID auth_token:nil];
}

-(id)initWithURL:(NSURL *)URL cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeoutInterval bucket:(NSString *)bucketID auth_token:(NSString *)auth_token {
  NSURL *newURL = [RunscopeURLRequest runscopeURLFromURL:URL bucket:bucketID];
  self = [super initWithURL:newURL cachePolicy:cachePolicy timeoutInterval:timeoutInterval];
  [self setRequestPortForURL:URL];
  if (auth_token) {
    [self setRequestAuthToken:auth_token];
  }
  return self;
}

-(void)setURL:(NSURL *)URL bucket:(NSString *)bucketID {
  [self setURL:URL bucket:bucketID auth_token:nil];
}

-(void)setURL:(NSURL *)URL bucket:(NSString *)bucketID auth_token:(NSString *)auth_token {
  NSURL *newURL = [RunscopeURLRequest runscopeURLFromURL:URL bucket:bucketID];
  [self setRequestPortForURL:URL];
  if (auth_token) {
    [self setRequestAuthToken:auth_token];
  }
  [super setURL:newURL];
}

-(void)setRequestPortForURL:(NSURL *)URL {
  if (![[URL port] isEqual: @80]) {
    [self setValue: [[URL port] stringValue] forHTTPHeaderField:@"Runscope-Request-Port"];
  }
}

-(void)setRequestAuthToken:(NSString *)auth_token {
  [self setValue:auth_token forHTTPHeaderField:@"Runscope-Bucket-Auth"];
}

+(NSURL *)runscopeURLFromURL:(NSURL *)URL bucket:(NSString *)bucketID {
  NSString *newHost;
  newHost = [[URL host]  stringByReplacingOccurrencesOfString:@"-" withString:@"--"]; //hyphens need to be doubled
  newHost = [NSString stringWithFormat:@"%@-%@.runscope.net", [newHost stringByReplacingOccurrencesOfString:@"." withString:@"-"], bucketID];
  NSMutableString *newPath = [[NSMutableString alloc] initWithString:@""];
  [URL.pathComponents enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
    if (idx != 0) {
      [newPath appendFormat:@"/%@", obj];
    }
  }];
  if ([URL parameterString]) {
    [newPath appendFormat:@";%@", [URL parameterString]];
  }
  if ([URL query]) {
    [newPath appendFormat:@"?%@", [URL query]];
  }
  NSString *newURLString = [NSString stringWithFormat:@"%@://%@%@", [URL scheme], newHost, newPath];
  return [NSURL URLWithString:newURLString];
}

+(id)requestWithURL:(NSURL *)URL cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeoutInterval bucket:(NSString *)bucketID {
  return [RunscopeURLRequest requestWithURL:URL cachePolicy:cachePolicy timeoutInterval:timeoutInterval bucket:bucketID auth_token:nil];
}

+(id)requestWithURL:(NSURL *)URL cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeoutInterval bucket:(NSString *)bucketID auth_token:(NSString *)auth_token {
  RunscopeURLRequest *request = [super requestWithURL:[self runscopeURLFromURL:URL bucket:bucketID] cachePolicy:cachePolicy timeoutInterval:timeoutInterval];
  [request setRequestPortForURL:URL];
  if (auth_token) {
    [request setRequestAuthToken:auth_token];
  }
  return request;
}

+(id)requestWithURL:(NSURL *)URL bucket:(NSString *)bucketID {
  return [RunscopeURLRequest requestWithURL:URL bucket:bucketID auth_token:nil];
}

+(id)requestWithURL:(NSURL *)URL bucket:(NSString *)bucketID auth_token:(NSString *)auth_token {
  RunscopeURLRequest *request = [super requestWithURL:[self runscopeURLFromURL:URL bucket:bucketID]];
  [request setRequestPortForURL:URL];
  if (auth_token) {
    [request setRequestAuthToken:auth_token];
  }
  return request;
}

@end
