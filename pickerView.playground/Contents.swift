//
//  FormUINumber.swift
//  ttc_bdn
//
//  Created by pasonatech on 2020/12/10.
//

import UIKit

protocol FormUINumberAndLabelDelegate: class {
    func totalCalc(view:FormUINumberAndLabel)
}

class FormUINumberAndLabel: UIView, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var contentView: CommonTextField!
    @IBOutlet weak var unitView: UILabel!
    @IBOutlet weak var packageCountView: UILabel!
    @IBOutlet weak var sumView: UILabel!
    @IBOutlet weak var packageUnitView: UILabel!
    @IBOutlet weak var errorImage: UIImageView!
    @IBOutlet weak var errorView: UILabel!
    
    weak var delegate: FormUINumberAndLabelDelegate?
    
    @IBInspectable var titleText: String! // タイトルのテキスト
    var pickerView: UIPickerView = UIPickerView()
    var list: [String] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        loadNib()
    }
    
    override func awakeFromNib() {
        // 多言語対応
        if (titleText != nil) {
            titleView.text = NSLocalizedString(titleText, comment: "")
        }
        
        for count in 1...100 {
            list.append(String(count))
        }
        
        pickerView.delegate = self
        pickerView.dataSource = self

        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "選択", style: .plain, target: self, action: #selector(doneHourPicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "キャンセル", style: .plain, target: self, action: #selector(cancelPicker));
        toolbar.backgroundColor = UIColor.white
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)

        self.contentView.inputView = pickerView
        self.contentView.inputAccessoryView = toolbar
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.contentView.text = list[row]
    }

    @objc func cancelPicker() {
        self.contentView.endEditing(true)
    }

    @objc func doneHourPicker() {
        self.contentView.endEditing(true)
        delegate?.totalCalc(view: self)
    }

    func loadNib() {
        if let view = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
            unitView.adjustsFontSizeToFitWidth = true
            sumView.adjustsFontSizeToFitWidth = true
            packageUnitView.adjustsFontSizeToFitWidth = true
            errorView.adjustsFontSizeToFitWidth = true
        }
    }
    
    func dispError() {
        errorImage.isHidden = false
        contentView.layer.borderColor = UIColor.red.cgColor
        contentView.backgroundColor = UIColor.BasicRed_1
    }
    
    func clearError() {
        errorView.text = ""
        errorImage.isHidden = true
        contentView.layer.borderColor = UIColor.BasicGray_2.cgColor
        contentView.backgroundColor = UIColor.white
    }

}
