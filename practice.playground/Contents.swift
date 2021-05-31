import UIKit

var str = "3.1"

//var a = str.toInt()!
var b = Int(str)
//var c = str.bridgeToObjectiveC().floatValue
var d = Double(str)

var e = NSString(string: str).integerValue
var f = NSString(string: str).floatValue
var g = NSString(string: str).doubleValue
