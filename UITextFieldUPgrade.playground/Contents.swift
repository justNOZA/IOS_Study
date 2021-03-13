import UIKit

class BargeSelectTextField: UITextField {
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(paste(_:)) || action == #selector(cut(_:)) || action == #selector(copy(_:)){
            return false
        }
        
        return super.canPerformAction(action, withSender: sender)
    }
    
    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}
