/*
送りたいバイナリデータを持つクラス
MIME-TYPEとfile nameとNSDataを保持します
*/
import Foundation

class RequestData {

    enum MimeType: String {
        case JPEG = "image/jpeg"
        case MP4 = "video/mp4"
    }

    var data: NSData
    var mimeType: MimeType
    var filename: String

    init(data: NSData, mimeType: MimeType, filename: String) {
        self.data = data
        self.mimeType = mimeType
        self.filename = filename
    }
}
