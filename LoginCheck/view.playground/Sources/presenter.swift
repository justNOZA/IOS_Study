//
//  LoginPresenter.swift
//  ttc_bdn
//
//  ログイン処理を行うPresenter
//  Created by Pasonatech on 2021/03/01.
//

import Foundation

/**
    ログイン結果
 */
enum LoginResult {
    case SUCCESS                              // 接続に成功
//    case ERR_INVALID_ID                       // ログインIDとパスワードが不正
    case ERR_NOT_CONNECTED                    // 接続エラー
    case ERR_NOT_BARGE_FOUND                  // バージ船リストが取得できなかった
    case MAINTENANCE                          // メンテナンス
}

protocol LoginPresnterInput : class {
    func loginTouched()-> (LoginResult, String?)
    func loginLoad()
}

class LoginPresenter : LoginPresnterInput  {
    
    weak var view : LoginViewController!
    var modelLogInfoInput : LogInfoInput                // ログイン情報管理
    var modelLoginToServer : LoginToServerModel         // ログイン認証処理
    var modelAccessToken : AccessTokenModel             // アクセストークン
    var modelBargeList : BargeListModel                 // バージ船一覧取得
    private var list = [String : String]()
    
    /**
        初期化
     */
    init(view: LoginViewController){
        self.view = view
        self.modelLogInfoInput = LoginInfoModel()
        self.modelLoginToServer = LoginToServerModel()
        self.modelAccessToken = AccessTokenModel()
        self.modelBargeList = BargeListModel()
    }

    /**
        ログインボタンタップ時の処理
        @return
     */
    func loginTouched()-> (LoginResult, String?){
        var ret = LoginResult.SUCCESS                   // 戻り値

        let check = view.loginCheckBox.isChecked

        //IDとPasswordを取得
        // 中身が入っていることはLoginViewControllerで確認済み
        let id = view.userIDView.text
        let pw = view.passwordView.text
        
        // ログイン認証を行う
        var isSend:Bool         //送信したか
        var resCode:Int         //HTTP応答コード
        var accessToken:String  //アクセストークン
        var isMaintenance: Bool //メンテナンスフラグ
        var errorMessage: String?
        (isSend, resCode, accessToken, isMaintenance, errorMessage) = modelLoginToServer.execLogin(loginID: id!, password: pw!)
        
        // 送信に成功したか？
        if(isSend == true){
            // レスポンスコード毎に処理を行う
            if((resCode == 200) && (accessToken != "")){
                // 200(正常終了)かつアクセストークンが取得できた場合
                // ログインとパスワードの保存処理を行う
                modelLogInfoInput.manageIdPassword(["id" : id!, "pw" : pw!], check)
                modelLogInfoInput.saveUserID(userID: id!)
                
                //　アクセストークンを保存する
                modelAccessToken.setAccessToken(accessToken: accessToken)
                modelLogInfoInput.saveLoginDate()
            }
            else if isMaintenance {
                ret = .MAINTENANCE
            }
            else{
                // その他エラーの場合
                // 通信エラーとする
                ret = LoginResult.ERR_NOT_CONNECTED
            }
        }
        else
        {
            // 送信に失敗した場合は通信エラーとする
            ret = LoginResult.ERR_NOT_CONNECTED
        }
        return (ret, errorMessage);
    }
    
    func loginLoad(){
        let result = modelLogInfoInput.readIdPassword()
        let check = modelLogInfoInput.getCheck()
        
        self.view.loginCheckBox.isChecked = check
        
        if check {
            if let id  = result["id"], let pw = result["pw"] {
                self.view.userIDView.text = id
                self.view.passwordView.text = pw
            }
        }
    }
    
    /**
        バージ船の一覧をサーバーから取得する
         @return バージ船の一覧（バージ船IDとバージ船名）
     */
    func getBargeList()-> ([String:String],String?)
    {
        var check : String?
        var value : [String:String] = [:]
        if let bargeList = modelBargeList.getBargeList() {
            if bargeList.errorCode == 401 ||
                bargeList.errorCode == 403 {
                check = NSLocalizedString("E401403", comment: "")
            }else if bargeList.errorCode == 400 ||
                     bargeList.errorCode == 500 ||
                     bargeList.errorCode == 404 {
                check = bargeList.messages?.joined(separator: "\n")
            }
        
            if let result = bargeList.datas {
                for list in result {
                    value.updateValue(list.bargeBoatId!, forKey: list.bargeBoatNm!)
                }
            }
        }
        return (value,check)
    }
    
    /**
        登録されているバージ船を端末から取得する
        @return 端末に登録しているバージ船ID
     */
    func getBargeID()->String
    {
        var ret:String = ""     //戻り値
        // 登録されているバージ船を端末から取得する
        let bargeInfo = modelBargeList.getSelectionItem()
        if let id = bargeInfo["id"] {
           ret = id
        }
        return ret
    }
    
}
