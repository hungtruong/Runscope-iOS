RunscopeURLRequest
======
RunscopeURLRequest is a subclass of NSMutableURLRequest that converts a URL to the Runscope URL scheme automagically. 

Usage
-----
Copy the RunscopeURLRequest.h and RunscopeURLRequest.m files into your Xcode project.
Import the header like so:

    #import "RunscopeURLRequest.h"


Use as you would a normal NSMutableURLRequest or NSURLRequest, including your Runscope bucket id:

	request = [RunscopeURLRequest requestWithURL:url bucket:runscopeBucketID];
     
If your URL uses a port other than 80, RunscopeURLRequest will also add the necessary "Runscope-Request-Port" header to your URL request.