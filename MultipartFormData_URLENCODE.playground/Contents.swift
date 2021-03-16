import Foundation
import UIKit
// UIImageをjpegにしてリクエストする
let image = UIImage(named: "hoge")
let jpegData = image!.jpegData(compressionQuality: 1)
let requestData = RequestData(data: jpegData, mimeType: JPEG, "hoge.jpeg")
let parameters = ["title":"hogehoge", "text": "hoge", "post_image": requestData]
if let request = API.URLRequest(method: .POST, path: "/hogehoge", parameters: parameters) {
    // requestを送る処理
}
