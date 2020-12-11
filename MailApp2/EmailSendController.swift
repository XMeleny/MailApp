//
//  EmailSendController.swift
//  MailApp2
//
//  Created by gtk on 2020/12/10.
//

import UIKit
import CoreData

class EmailSendController:UIViewController{
    
    @IBOutlet weak var receiverTextField: UITextField!
    @IBOutlet weak var subjectTextField: UITextField!
    
    let LONG_TOAST_TIME=0.8
    let SHORT_TOAST_TIME=0.5
    
    let TOAST_TIME=0.5
    
    @IBAction func sendEmail(_ sender: UIBarButtonItem) {
        let receiver = receiverTextField.text
        let subject = subjectTextField.text
        
        save(receiver, subject)
    }
    
    func save(_ receiver:String?, _ subject:String?)  {
        if receiver == nil || subject == nil || receiver!.isEmpty || subject!.isEmpty {
            showAlertAndGoBack("收件人或主题为空，请检查",false)
            return
        }
        
        saveEmail(receiver: receiver!, subject: subject!)
        showAlertAndGoBack("发送成功",true)
    }
    
    func showAlertAndGoBack(_ title:String,  _ shouldGoBack:Bool) {
        let alertController = UIAlertController(title:title, message: nil, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
        
        // toast time can't be too short(idk why)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+TOAST_TIME) {
            // dismiss the dialog
            self.presentedViewController?.dismiss(animated: false, completion: nil);
            // dismiss the whole page
            if(shouldGoBack){
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
