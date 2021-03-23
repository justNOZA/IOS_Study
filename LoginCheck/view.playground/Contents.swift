//
//  LoginViewController.swift
//  ttc_bdn
//
//  Created by pasonatech on 2020/12/07.
//

import UIKit
import Security

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userIDView: CommonTextField!
    @IBOutlet weak var userIDErrorLabel: UILabel!
    @IBOutlet weak var userIDStackView: UIStackView!
    @IBOutlet weak var passwordView: PasswordTextField!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var passwordStackView: UIStackView!
    @IBOutlet weak var loginButton: UIButton!
    //checkBoxの状況を確認するため
    @IBOutlet weak var loginCheckBox: CheckBox!
    var presenter : LoginPresenter!
    var utilError = VlidationErrorView()
    var bargeShipList: [String:String] = [:]
    
    //エラーメッセージ
    let E0603 = "ユーザーIDもしくはパスワードが間違っています。"
    let E0604 = "サーバに接続できません。通信状況が良い場所で再度操作を実施してください"
    let E0606 = "バージ船の情報が取得できません。お問い合わせ窓口にご連絡ください。"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LoginPresenter(view: self)
        passwordView.delegate = self
        presenter.loginLoad()
    }

    /**
        ログインボタンタップ時のイベント処理
     */
    @IBAction func loginButtonTouched(_ sender: Any) {
        
        clearError()
        
        var isResult: Bool = true
        
        userIDView.validate(type: .unicode, errorMessageOn: userIDErrorLabel, errMsg: NSLocalizedString("E0308", comment: ""), isResult: &isResult)
        userIDView.validate(type: .length(min: 0, max: 32), errorMessageOn: userIDErrorLabel, errMsg: NSLocalizedString("E0301", comment: ""), isResult: &isResult)
        userIDView.validate(type: .empty, errorMessageOn: userIDErrorLabel, errMsg: NSLocalizedString("E0309", comment: ""), isResult: &isResult)
        if userIDErrorLabel.text?.isEmpty == false {
            utilError.errorDispAlpha(textField: userIDView, stack: userIDStackView)
        }
        
        passwordView.validate(type: .unicode, errorMessageOn: passwordErrorLabel, errMsg: NSLocalizedString("E0308", comment: ""), isResult: &isResult)
        passwordView.validate(type: .length(min: 8, max: 16), errorMessageOn: passwordErrorLabel, errMsg: NSLocalizedString("E0302", comment: ""), isResult: &isResult)
        passwordView.validate(type: .empty, errorMessageOn: passwordErrorLabel, errMsg: NSLocalizedString("E0310", comment: ""), isResult: &isResult)
        if passwordErrorLabel.text?.isEmpty == false {
            utilError.errorDispAlpha(textField: passwordView, stack: passwordStackView)
        }
        
        if isResult == false {
            return
        }

        var isBargeSelect:Bool = true               // バージ船選択画面を表示するか
        var result :LoginResult            // ログイン処理結果
        var error : String?
        var errorMessage : String?
        //IDとPasswordを記録,削除,ログイン認証処理
        (result, errorMessage) = presenter.loginTouched()
        
        if let alertMsg = errorMessage{
            loginError(result: nil, error: alertMsg)
        }
        
        if( result == LoginResult.SUCCESS ){
            // ログインに成功した場合はバージ船のチェックを行う
            (result, isBargeSelect , bargeShipList, error) = checkBargeSelect()
            if let message = error{
                loginError(result: nil, error: message)
            }
        }
        
        if( result == LoginResult.SUCCESS ){
            // 次の画面（バージ船選択画面かメニュー画面）へ遷移する
            // エラーが発生した場合は遷移しない
            nextScreen(isBargeSelect: isBargeSelect)
        
            // ログイン保存チェックが無い場合は
            if !loginCheckBox.isChecked {
                userIDView.text = ""
                passwordView.text = ""
            }
        }
        else{
            // ログインエラー処理
            loginError(result: result, error: nil)
        }
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureObserver()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        util.sendAnalysticsLogScreenView(screenName: screenName.login.rawValue)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.view.endEditing(true)
        if let svc = segue.destination as? BargeSelectViewController {
            svc.fullList = bargeShipList
            svc.isVisited = false
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /// Notification発行
    func configureObserver() {
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(keyboardWillShow(_:)),
                                 name: UIResponder.keyboardWillShowNotification, object: nil)
        notification.addObserver(self, selector: #selector(keyboardWillHide(_:)),
                                 name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(viewWillEnterForeground(
                    notification:)), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(viewDidEnterBackground(
                    notification:)), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    /// キーボードが表示時に画面をずらす。
    @objc func keyboardWillShow(_ notification: Notification?) {
        if let keyboardSize = (notification?.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            } else {
                let suggestionHeight = self.view.frame.origin.y + keyboardSize.height
                self.view.frame.origin.y -= suggestionHeight
            }
        }
    }

    /// キーボードが降りたら画面を戻す
    @objc func keyboardWillHide(_ notification: Notification?) {
        if self.view.frame.origin.y != 0 {
           self.view.frame.origin.y = 0
       }
    }
    
    @objc func viewWillEnterForeground(notification: Notification) {
        self.view.endEditing(true)
    }
    
    @objc func viewDidEnterBackground(notification: Notification) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginButtonTouched(loginButton!)
        return true
    }
    
    func clearError() {
        utilError.errorClearAlpha(textField: userIDView, stack: userIDStackView, label: userIDErrorLabel)
        utilError.errorClearAlpha(textField: passwordView, stack: passwordStackView, label: passwordErrorLabel)
    }
    
    /**
        次の画面（バージ船選択画面、メニュー画面）へ遷移する
        @return 通信結果
        @return バージ船選択が必要
    */
    func checkBargeSelect() -> (LoginResult, Bool , [String:String], String?){
        var loginResult:LoginResult = LoginResult.SUCCESS   // 通信に成功したか
        var isBargeSelect:Bool = true                       // バージ船選択画面に遷移するか
        
        // ユーザーの乗船するバージ船IDを、端末から取得する
        let bargeID = presenter.getBargeID()
        
        // サーバーからバージ船の一覧を取得する
        let (list, error401403) = presenter.getBargeList()
        
        bargeShipList = list

        // サーバーからバージ船を取得できた
        if( bargeShipList.count > 0)
        {
            if(bargeID != "")
            {
                // サーバーから取得したバージ船の一覧の中に、端末に保存されているバージ船があるか？
                for list in bargeShipList {
                    if( list.value == bargeID ){
                        // バージ船一覧の中に端末登録バージ船と同じIDが見つかったので
                        // バージ選択画面には遷移不要
                        isBargeSelect = false
                    }
                }
            }
        }
        else{
            // サーバーから取得したバージ船が0件ならエラーとする
            loginResult = LoginResult.ERR_NOT_BARGE_FOUND
        }
       
        return (loginResult, isBargeSelect , bargeShipList, error401403)
    }
    
    /**
        次の画面（バージ船選択画面、メニュー画面）へ遷移する
        @return なし
    */
    func nextScreen(isBargeSelect:Bool )
    {
        // 画面の遷移先を決定する
        if(isBargeSelect == true ) {
            //　バージ船を新しく選択する必要がある場合はバージ船選択画面へ遷移する
            self.performSegue(withIdentifier: toView.barge.rawValue, sender: nil)
        }
        else{
            // 既にバージ船が登録済みの場合はメニュー画面へ遷移する
            self.performSegue(withIdentifier: toView.menu.rawValue, sender: nil)
        }
    }

    /**
        次の画面（バージ船選択画面、メニュー画面）へ遷移する
        @return なし
    */
    func loginError(result: LoginResult?, error : String?)
    {
        var errorMsg = ""        // エラーメッセージ
        if let loginesult = result {
            // 処理に失敗した場合はエラーメッセージをダイアログ表示する
            switch loginesult {
            case LoginResult.ERR_NOT_CONNECTED:     // 通信エラー
                errorMsg = E0604
                break;
            case LoginResult.ERR_NOT_BARGE_FOUND:   // バージ船一覧リストが取得できなかった
                errorMsg = E0606
                break;
            case .MAINTENANCE:
                errorMsg = NSLocalizedString("E0311", comment: "")
                break;
            default:                                // その他のエラーの場合(フェール処理)
                errorMsg = E0603
                break;
            }
        }
        if let msg = error {
            errorMsg = msg
        }
        if( errorMsg != "")
        {
            let alert = UIAlertController(title: "ログインエラー", message: errorMsg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "閉じる", style: .default, handler: nil))
            self.present(alert, animated: true, completion:nil)
        }
    }
}
