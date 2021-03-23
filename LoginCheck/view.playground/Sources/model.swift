//
//  LoginToServerModel.swift
//  ttc_bdn
//
//  サーバへのログイン認証処理
//  Created by 小島毅 on 2021/03/03.
//

import Foundation
import GRDB

/**
    サーバーへのログイン認証処理クラス
 */
class LoginToServerModel {
    var API = api()                 // サーバー通信API
    var body = Data()               // https BODY部分
    
    /**
        ログイン認証
        ユーザーIDとパスワードをサーバへ送信してログイン認証処理を行う
        認証に成功した場合はアクセストークンを受信する
            @param loginID ログインID
            @param password パスワード
            @return ( isSend: 送信したか、rescode: httpレスポンスコード、accessToken: アクセストークン）
     */
    func execLogin(loginID: String, password: String) -> (Bool, Int, String, Bool, String?) {
        var isSend:Bool = false         // 戻り値（送信したか？）
        var resCode:Int = 200           // 戻り値（レスポンスコード）
        var accessToken:String = ""     // 戻り値 (アクセストークン）
        var isMaintenance: Bool = false // 戻り値 (メンテナンスフラグ)
        var message : String?
        
        // リクエストを作成する
        let url = URL(string: "\(API.apiURL)tablet/user/login")!                    // URL
        var request = URLRequest(url: url)                                          // リクエスト
        request.httpMethod = "POST"                                                 // POST通信
        request.timeoutInterval = APITimeout                                        // タイムアウト時間
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")    // ヘッダ
        
        // BODYに送信用のJSONを追加する
        let jsonData:[String: String] = [
            "loginId": loginID,             // loginID
            "password": password            // パスワード
        ]
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: jsonData, options: [])
        }catch{
            
            // BODYの作成に失敗
            return (isSend, resCode, accessToken, isMaintenance, nil)
        }
        
        // サーバーと通信を行う
        var data : Data?
        var response:URLResponse?       // レスポンス
        var error:Error?                // エラーコード
        (data, response, error) = API.execute(request)
        
        if data != nil {
            let result = try? JSONDecoder().decode(ErrorMessage.self, from: data!)
            message = result?.messages?.joined(separator: "\n")
        }
        // エラーが発生していない場合
        if (error == nil) {
            
            // 通信には成功した
            isSend = true
            
            // レスポンスのヘッダ部分からステータスコードとAuthの値を取得する
            if let httpResponse = response as? HTTPURLResponse {
                resCode = httpResponse.statusCode
                if let auth = httpResponse.allHeaderFields["Authorization"] as? String {
                    // Authのデータは先頭に「Bearer 」が付与されているので
                    // 取り除いてアクセストークンを取得する
                    accessToken = auth.replacingOccurrences(of: "Bearer ", with: "")
                } else if let contentType = httpResponse.allHeaderFields["Content-Type"] as? String {
                    if contentType.lowercased().contains("text/html") {
                        isMaintenance = true
                    }
                }
            }
        }
        return (isSend, resCode, accessToken, isMaintenance, message)
    }
    
}

struct ErrorMessage : Codable {
    var messages : [String]?
    var result : String?
}
