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
  NSURL *newURL = [RunscopeURLRequest runscopeURLFromURL:URL bucket:bucketID];
  self = [super initWithURL:newURL];
  [self setRequestPortForURL:URL];
  return self;
}

-(id)initWithURL:(NSURL *)URL cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeoutInterval bucket:(NSString *)bucketID {
  NSURL *newURL = [RunscopeURLRequest runscopeURLFromURL:URL bucket:bucketID];
  self = [super initWithURL:newURL cachePolicy:cachePolicy timeoutInterval:timeoutInterval];
  [self setRequestPortForURL:URL];
  return self;
}

-(void)setURL:(NSURL *)URL bucket:(NSString *)bucketID{
  NSURL *newURL = [RunscopeURLRequest runscopeURLFromURL:URL bucket:bucketID];
  [self setRequestPortForURL:URL];
  [super setURL:newURL];
}

-(void)setRequestPortForURL:(NSURL *)URL {
  if (![[URL port] isEqual: @80]) {
    [self setValue: [[URL port] stringValue] forHTTPHeaderField:@"Runscope-Request-Port"];
  }
}

+(NSURL *)runscopeURLFromURL:(NSURL *)URL bucket:(NSString *)bucketID{
  NSString *newHost = [NSString stringWithFormat:@"%@-%@.runscope.net", [[URL host] stringByReplacingOccurrencesOfString:@"." withString:@"-"], bucketID];
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
  RunscopeURLRequest *request = [super requestWithURL:[self runscopeURLFromURL:URL bucket:bucketID] cachePolicy:cachePolicy timeoutInterval:timeoutInterval];
  [request setRequestPortForURL:URL];
  return request;
}

+(id)requestWithURL:(NSURL *)URL bucket:(NSString *)bucketID {
  RunscopeURLRequest *request = [super requestWithURL:[self runscopeURLFromURL:URL bucket:bucketID]];
  [request setRequestPortForURL:URL];
  return request;
}

@end
