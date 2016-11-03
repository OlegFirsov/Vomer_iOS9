//
//  MyURLProtocol.swift
//  Vomer
//
//  Created by MAC  on 26.08.16.
//  Copyright © 2016 MAC . All rights reserved.
//

import UIKit

var requestCount = 1

class MyURLProtocol: NSURLProtocol {

    var connection: NSURLConnection!
    
    func connection(connection: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
        self.client!.URLProtocol(self, didReceiveResponse: response, cacheStoragePolicy: .NotAllowed)
        //debugPrint("response: \(response.URL))")
        
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
        self.client!.URLProtocol(self, didLoadData: data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        self.client!.URLProtocolDidFinishLoading(self)
    }
    
    func connection(connection: NSURLConnection!, didFailWithError error: NSError!) {
        self.client!.URLProtocol(self, didFailWithError: error)
    }
    
    override class func canInitWithRequest(request: NSURLRequest) -> Bool {
        if request.URL!.absoluteString.containsString("numbers.php") {
        //debugPrint("Request #\(requestCount): URL = \(request.URL!.absoluteString)")
        
        //debugPrint("request.allHTTPHeaderFields: \(request.allHTTPHeaderFields)")
        let body = String(data: request.HTTPBody!, encoding: NSUTF8StringEncoding) ?? ""
        //debugPrint("body: \(body)")//func=get-my-info from numbers.php
        
        requestCount += 1
                }
        if NSURLProtocol.propertyForKey("MyURLProtocolHandledKey", inRequest: request) != nil {
            return false// false - dont processing(handle) request  - request as is, true -            processing(handle) request - go startLoading
            
        }
        return true
    }
    
    override class func canonicalRequestForRequest(request: NSURLRequest) -> NSURLRequest {
        //debugPrint("allHTTPHeaderFields: \(request.HTTPBody)")
        return request
    }
    
    
    
    override class func requestIsCacheEquivalent(aRequest: NSURLRequest,
                                                 toRequest bRequest: NSURLRequest) -> Bool {
        return super.requestIsCacheEquivalent(aRequest, toRequest: bRequest)
    }
    
    override func startLoading() {
        let newRequest = self.request.mutableCopy() as! NSMutableURLRequest
        NSURLProtocol.setProperty(true, forKey: "MyURLProtocolHandledKey", inRequest: newRequest)
        
        self.connection = NSURLConnection(request: newRequest, delegate: self)
        //self.connection = NSURLConnection(request: self.request, delegate: self)
    }
    
    override func stopLoading() {
        if self.connection != nil {
            self.connection.cancel()
        }
        self.connection = nil
    }
}
