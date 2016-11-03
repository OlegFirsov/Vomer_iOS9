//
//  ViewController.swift
//  Vomer_iOS9
//
//  Created by MAC  on 22.07.16.
//  Copyright © 2016 MAC . All rights reserved.
//

import UIKit
//import JavaScriptCore



class ViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    //var JSHandler = ""
    //let vomerJSHandler = "mpAjaxHandler"
    var userid = ""
    var socket = SocketIOClient(socketURL: NSURL(string: "https://my.vomer.com.ua:3300")!)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //JSHandler = NSBundle.mainBundle().pathForResource("ajax_handler", ofType: "js")!
        self.webView.allowsInlineMediaPlayback = true
        self.webView.mediaPlaybackAllowsAirPlay = true
        self.webView.mediaPlaybackRequiresUserAction = false//add a sound
        let url = NSURL(string: "https://vomer.com.ua/chat_view.php")
        let request = NSURLRequest(URL:url!)
        //self.webView.loadRequest(request)
        
        //for notification with socket.io
        getUserID()
        /*let surl = NSURL(string: "https://my.vomer.com.ua:3300")
        let socket = SocketIOClient(socketURL: surl!)
        socket.on("connection") {data, ack in
            debugPrint("Waiting for notification")
            //ack?("I got your message, and Ill send your notification")
            self.socket.emit("Vomer Iphone",self.userid)
            //self.showRemoteNotification("Notification", message: "Hello from VOMER")
        }*/
        self.addHandlers()
        socket.connect()
        
    }
    
    
    func addHandlers() {
        socket.on("error") {data in
            debugPrint("socket ERROR")
            debugPrint(data)
        }
        socket.on("connect") {data, ack in
            debugPrint("Got event: connect, with description: \(self.socket.description)")
           
            let cllbck = Callback(data: data, ack: ack)
            
            self.socket.emit("my nick", self.userid, "", "VOMER", "E8790n_g1j8.jpg", cllbck)
            debugPrint("data : \(data)")
        }
        socket.on("vomer message") {data, ack in
            debugPrint("Got event: vomer message, with description: \(self.socket.description)")
            debugPrint("data : \(data)")
        }
        
        /*socket.onAny {
         debugPrint("Got noAnyEvent: \($0.event), with items: \($0.items)")

            var status = "Not Connected"
            if self.socket.status.rawValue == 3 {
                status = "Connected"
            }
            debugPrint("with status: \(status)")
        }*/
    }
    
    
    override func viewWillAppear(animated: Bool) {
        webView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
    
        debugPrint("error code: \(error?.code)  error.description: \(error?.description)")
        
        if (error!.domain == NSURLErrorDomain && error!.code != -999){
        //NSURLErrorFailingURLErrorKey.rangeOfString("youtube") == nil){
          //|| error!.code == NSURLErrorNotConnectedToInternet || error!.code == NSURLErrorNetworkConnectionLost{
          //let filepath = NSBundle.mainBundle().pathForResource("no_connection", ofType: "gif")
            
            
          let fphtml = NSBundle.mainBundle().pathForResource("no_connection", ofType: "html")
          //let gif = NSData(contentsOfFile: filepath!)
            
          let url = NSURL.fileURLWithPath(fphtml!)
          let request = NSURLRequest(URL: url)
          self.webView.loadRequest(request)
            
            /*do{ var htmlString = try NSString(contentsOfFile: fphtml!, encoding: NSUTF8StringEncoding)
                self.webView.loadHTMLString(htmlString as String, baseURL: nil)
            }
            catch{debugPrint("Error no_connection.html!")}*/
          //let url = NSURL(string: "https://vomer.com.ua/chat_view.php")
          //self.webView.loadData(gif!, MIMEType: "image/gif", textEncodingName: String(), baseURL: url!)            
          //clear cache for next load
          //NSURLCache.sharedURLCache().removeAllCachedResponses();
      }
    }
    
    
    //var reqNum: Int = 1
    //catch AJAX!!!!
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        /*if request.URL?.scheme == vomerJSHandler{
            let requestedUrlString = request.URL!.absoluteString.substringFromIndex(vomerJSHandler.startIndex.advancedBy(vomerJSHandler.characters.count+3))
            debugPrint("requestedUrlString: \(requestedUrlString)")
            return false
        }*/
        //let resp = NSURLCache.sharedURLCache().cachedResponseForRequest(request)//dont work for POST
        //debugPrint("response= \(resp?.data)")
        
        return true
        
        
        /*    debugPrint("Request \(reqNum)")
            debugPrint("Request URL: \(request.URL)")
            //debugPrint(request.mainDocumentURL.")
            reqNum += 1
            let jsonData = request.HTTPBody as NSData?
            if jsonData != nil{
            do{ let resObject = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: []) as! [String: AnyObject]
                for it in resObject.keys{
                    debugPrint("HTTPBody: \(it) - \(resObject[it])")}
            }
            catch{debugPrint("error json: \(error)")}
            }
            else{debugPrint("jsonData == nil")}
            return true*/
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        /*var str = "var s_ajaxListener = new Object();s_ajaxListener.tempOpen = XMLHttpRequest.prototype.open;s_ajaxListener.tempSend = XMLHttpRequest.prototype.send;"
        str += "s_ajaxListener.callback = function () {window.location='mpAjaxHandler://' + this.url;};"
        str += "XMLHttpRequest.prototype.open = function(a,b){if (!a) var a='';if (!b) var b='';s_ajaxListener.tempOpen.apply(this, arguments);"
        str += "s_ajaxListener.method = a;s_ajaxListener.url = b;if (a.toLowerCase() == 'get') {s_ajaxListener.data = b.split('?');"
        str += "s_ajaxListener.data = s_ajaxListener.data[1];}}"
        str += "XMLHttpRequest.prototype.send = function(a,b){if (!a) var a='';if (!b) var b='';s_ajaxListener.tempSend.apply(this, arguments);"
        str += "if(s_ajaxListener.method.toLowerCase() == 'post')s_ajaxListener.data = a;s_ajaxListener.callback();}return 1;"
        if let scr = webView.stringByEvaluatingJavaScriptFromString(str){
        debugPrint("my script: \(scr)")
        } else {
            debugPrint("my script is nil")
        }*/
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
            }
    
    
    func getUserID() {
        let storage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        var cookie: NSHTTPCookie
        for cookie in storage.cookies! {
            if cookie.name == "users" {
                debugPrint("\(cookie.name): \(cookie.value)")
                userid = cookie.value
            }
            if cookie.name == "number" {
                debugPrint("\(cookie.name): \(cookie.value)")
            }
        }        
    }
    
    func showRemoteNotification(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)

    }
   
    
    
}


