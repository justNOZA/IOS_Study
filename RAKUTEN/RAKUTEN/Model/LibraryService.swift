//
//  LibraryService.swift
//  RAKUTEN
//
//  Created by Pasonatech on 2021/02/24.
//

import Foundation

class LibraryService {
    
    private let url = "https://app.rakuten.co.jp/services/api/BooksTotal/Search/20170404?format=json&keyword=%E6%9C%AC&booksGenreId=000&applicationId=1074925184602464392"
}
extension LibraryService {
    func downloadData() -> [LibArray]{
        var libList = [LibArray]()
//        var flag = true
        let dataTask = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            if let json = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: json, options: []) as! [String: Any]
                    let items = json["Items"] as! [[String: Any]]
                    for  value in items {
                        if let v = value as? [String:Any]{
                            if let content = v["Item"] as? [String: Any]{
                                let libArray = LibArray(title: content["title"] as! String, author: content["author"] as! String, publisherName: content["publisherName"] as! String, samllImageUrl: content["smallImageUrl"] as! String, largeImageUrl: content["largeImageUrl"] as! String, itemCaption: content["itemCaption"] as! String)
                                libList.append(libArray)
                            }
                        }
                    }
                }catch {
                    print(error)
                }
            }
//            flag = false
        }
        dataTask.resume()
//        while flag {}
        return libList
    }
}
// 전체를 다 받아와서 원하는 것만 골라서 써보자. 
