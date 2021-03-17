import UIKit

var str = "Hello, playground"

//request.addValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")

func urlEncode(_ ue : String) -> String? {
    var allowed = CharacterSet.alphanumerics
    allowed.insert(charactersIn: "-._* ")
    var result = ue.addingPercentEncoding(withAllowedCharacters: allowed)
    result = result?.replacingOccurrences(of: " ", with: "+")
    return result
}

func paramsCreate(param: achievementInquiryParams,_ value: String?, _ body: inout [String]) {
    guard let unwrappedData = value else { return }
    if unwrappedData.isEmpty {
        return
    }
    if var url_encode = urlEncode("\(param)"){
        url_encode += "="
        if let encod = urlEncode(unwrappedData){
            url_encode += encod
            let bodyText = url_encode
            body.append(bodyText)
        }
    }
}
