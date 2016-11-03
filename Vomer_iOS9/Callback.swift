import UIKit

public class Callback {
    
    var requestdata: NSData
    var fack: SocketAckEmitter
    
    init(data: NSArray, ack: SocketAckEmitter) {
        requestdata = try! NSJSONSerialization.dataWithJSONObject(data, options: NSJSONWritingOptions.PrettyPrinted) as NSData!
        requestdata.base64EncodedStringWithOptions([])
        fack = ack
        debugPrint("requestdata: \(requestdata)")
    }
    
    //public func callback() {
    //    debugPrint("socket connected")
    //}

}