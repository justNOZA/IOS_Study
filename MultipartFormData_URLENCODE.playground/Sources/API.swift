import Foundation
import UIKit
/*
NSURLRequestを作成するクラス
ここにAPIにRequestを送る処理も書いていました
*/
class API {

    enum Method: String {
        case GET = "GET"
        case POST = "POST"
    }

    class func baseURL() -> NSURL {
        return NSURL(string: "リクエストを送るURL")!
    }

    class func URLRequest(method: Method, path: String, parameters: [String:AnyObject]) -> NSURLRequest? {
        if let components = NSURLComponents(url: baseURL() as URL, resolvingAgainstBaseURL: true) {
            let request = NSMutableURLRequest()
            request.httpMethod = method.rawValue

            if method == .GET {
                components.query = API.Helper.stringFromObject(parameters, encoding: NSUTF8StringEncoding)
            } else if method == .POST {
                var contentType: String?
                var paramsData: NSData?
                if API.Helper.isMultiParams(params: parameters) {
                    let boundary = "POST-boundary-\(arc4random())-\(arc4random())"
                    paramsData = API.Helper.multiDataFromObject(object: parameters, boundary: boundary)
                    contentType = "multipart/form-data; boundary=\(boundary)"
                } else {
                    paramsData = API.Helper.dataFromObject(parameters, encoding: NSUTF8StringEncoding)
                    contentType = "application/x-www-form-urlencoded"
                }

                if let params = paramsData {
                    request.setValue(contentType, forHTTPHeaderField: "Content-Type")
                    request.setValue("\(params.length)", forHTTPHeaderField: "Content-Length")
                    request.httpBody = params as Data
                }
            }

            components.path = "???"
            request.url = components.url
            // responseがjsonの場合
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            return request
        }

        return nil
    }

    class Helper {

        class func isMultiParams(params: [String:AnyObject]) -> Bool {

            var isMultiParams = false

            for (_, value) in params {
                if value is RequestData {
                    isMultiParams = true
                    break
                }
            }

            return isMultiParams
        }

        class func dataFromObject(object: AnyObject, encoding: String.Encoding) -> NSData? {
            let string = stringFromObject(object: object, encoding: encoding)
            return string.data(using: encoding, allowLossyConversion: false) as NSData?
        }

        class func stringFromObject(object: AnyObject, encoding: String.Encoding) -> String {
            var pairs = [String]()

            if let dictionary = object as? [String: AnyObject] {
                for (key, value) in dictionary {
                    let string = (value as? String) ?? "\(value)"
                    let pair = "\(key)=\(string)"
                    pairs.append(pair)
                }
            }

            return pairs.joined(separator: "&")
        }

        class func multiDataFromObject(object: [String:AnyObject], boundary: String) -> NSData? {
            var data = NSMutableData()

            let prefixString = "--\(boundary)\r\n"
            let prefixData = prefixString.data(using: <#String.Encoding#>, usingEncoding: NSUTF8StringEncoding)!

            let seperatorString = "\r\n"
            let seperatorData = seperatorString.data(using: <#String.Encoding#>, usingEncoding: NSUTF8StringEncoding)!

            for (key, value) in object {

                var valueData: NSData?
                var valueType: String?
                var filenameClause = ""

                if value is RequestData {
                    let requestData = value as! RequestData
                    if let data = requestData.getData() {
                        valueData = data
                        valueType = requestData.mimeType.rawValue
                        filenameClause = " filename=\"\(requestData.filename)\""
                    }
                } else {
                    let stringValue = "\(value)"
                    valueData = stringValue.dataUsingEncoding(NSUTF8StringEncoding)!
                }

                if valueData == nil {
                    continue
                }
                data.appendData(prefixData)
                let contentDispositionString = "Content-Disposition: form-data; name=\"\(key)\";\(filenameClause)\r\n"
                let contentDispositionData = contentDispositionString.dataUsingEncoding(NSUTF8StringEncoding)
                data.appendData(contentDispositionData!)
                if let type = valueType {
                    let contentTypeString = "Content-Type: \(type)\r\n"
                    let contentTypeData = contentTypeString.dataUsingEncoding(NSUTF8StringEncoding)
                    data.appendData(contentTypeData!)
                }
                data.appendData(seperatorData)
                data.appendData(valueData!)
                data.appendData(seperatorData)
            }

            let endingString = "--\(boundary)--\r\n"
            let endingData = endingString.dataUsingEncoding(NSUTF8StringEncoding)!
            data.appendData(endingData)

            return data
        }
    }
}
