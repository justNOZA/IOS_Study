//
//  GetUrl.swift
//  YoutubeTableSenti
//
//  Created by Pasonatech on 2021/02/24.
//

import Foundation

class GetUrl {
    func getNews() -> [[String:Any]]?{
        let newsUrl = "https://newsapi.org/v2/top-headlines?country=kr&apiKey=316fd8ae63be4f2698feaf4c64b9719e"
        var article: [[String:Any]]?
        var flag = true
        let task = URLSession.shared.dataTask(with: URL(string:newsUrl)!) { (data, response, error) in
            if let datajson = data {
                //json파싱 !
                do {
                    let json = try JSONSerialization.jsonObject(with: datajson, options: []) as! Dictionary<String, Any>
                    article = json["articles"] as! [[String:Any]]
//                    for (idx, value) in article.enumerated(){
//                        if let v = value as? [String:Any] {
//                            print(v["title"])
//                        }
//                    }
                    //Dictionary
                } catch {
                    print(error)
                }
            }
            flag = false
        }
        task.resume()
        while flag{}
        return article
    }
}
