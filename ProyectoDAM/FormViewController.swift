//
//  FormViewController.swift
//  ProyectoDAM
//
//  Created by Tania Fontcuberta Mercadal on 26/2/16.
//  Copyright © 2016 Xavi. All rights reserved.
//

import UIKit
import MessageUI

class FormViewController: UIViewController, MFMailComposeViewControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    
    @IBOutlet weak var subject: UITextField!
    @IBOutlet weak var message: UITextView!
    
    var sendTo : [String] = ["damproject@gmail.com"]
    var insideMessage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subject.delegate = self
        message.delegate = self
        
        message!.layer.borderWidth = 1
        message!.layer.borderColor = UIColor.grayColor().CGColor
        
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func textViewDidBeginEditing(textView: UITextView) {
        if(!insideMessage){
            message.text = "";
            insideMessage = true;
        }
        
    }
    
    @IBAction func sendMail(sender: AnyObject) {
        print(insideMessage)
        if (message.text != "" && insideMessage == true && subject.text != "") {
            let picker = MFMailComposeViewController()
            picker.mailComposeDelegate = self
            picker.setToRecipients(sendTo)
            picker.setSubject(subject.text!)
            picker.setMessageBody(message.text!, isHTML: true)
            
            presentViewController(picker, animated: true, completion: nil)
            
        }
        else{
            self.showSimpleAlert("¡Error!", message: "No se puede enviar un mensaje vacio.", buttonText: "Volver a intentarlo.")
        }
    }
    
    // MFMailComposeViewControllerDelegate
    
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // UITextViewDelegate
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        message.text = textView.text
        
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }

    @IBAction func closeView(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func showSimpleAlert(title: String, message: String, buttonText: String){
        let alertController = UIAlertController(title: title, message:message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}
