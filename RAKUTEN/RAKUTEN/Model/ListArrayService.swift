//
//  ListArrayService.swift
//  RAKUTEN
//
//  Created by Pasonatech on 2021/02/25.
//

import Foundation

class ListArrayService {
    private let url = "https://app.rakuten.co.jp/services/api/BooksTotal/Search/20170404?format=json&keyword=%E6%9C%AC&booksGenreId=000&applicationId=1074925184602464392"
}
extension ListArrayService {
    func downloadData(_ completionHandler: @escaping ([Items]) -> Void){
        
        let task = URLSession.shared.dataTask(with: URL(string: self.url)!) { (data, response, error) in
            if let json = data {
                do {
                    let jsonData = try JSONDecoder().decode(RakutenLibrary.self, from: json)
//                    if let itemData = jsonData.items{
//                        print(itemData[0].item?.title)
//                    }
                    if let libData = jsonData.items{
                        DispatchQueue.global().asyncAfter(deadline: .now() + 2.0){
                            completionHandler(libData)
                        }
                    }
                } catch { print(error) }
            }
        }
        task.resume()
    }
}
