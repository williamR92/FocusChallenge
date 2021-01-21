//
//  ViewController.swift
//  FocusChallenge
//
//  Created by Carlos Rosales on 1/19/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        let screenBounds = UIScreen.main.bounds
        widthView = screenBounds.width
        heightView = screenBounds.height
    }

    var load = false
    override func viewDidLayoutSubviews() {
        if(!load){
            heightStatusBar = self.view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
            addForm()
            load = true
        }
        
    }

    let viewForm = UIView()
    let lblWelcome = UILabel()
    let lblUser = UILabel()
    let lblPass = UILabel()
    let txtUser = UITextField()
    let txtPass = UITextField()
    let btnEye = UIButton()
    let btnSend = UIButton()
    
    func addForm(){
        viewForm.frame = CGRect(x: 0, y: widthView/2, width: widthView, height: heightView - (widthView/2))
        
        lblWelcome.frame = CGRect(x: 0, y: widthView/9, width: widthView/1.3, height: widthView/7)
        lblWelcome.center.x = self.view.frame.width/2
        lblWelcome.textAlignment = .left
        lblWelcome.numberOfLines = 0
        let myParagraphStyle1 = NSMutableParagraphStyle()
        myParagraphStyle1.lineSpacing = 0.8
        myParagraphStyle1.lineHeightMultiple = 0.8
        let concatenation = NSMutableAttributedString(string: "Welcome,\n", attributes: [ NSAttributedString.Key.font: UIFont(name:"Poppins-Bold", size: view.frame.width/18) as Any , NSAttributedString.Key.foregroundColor : UIColor.white])
        let concatenation2 = NSMutableAttributedString(string: "Login to continue..", attributes: [ NSAttributedString.Key.font: UIFont(name:"Poppins-Regular", size: view.frame.width/23) as Any , NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.paragraphStyle : myParagraphStyle1])
        concatenation.append(concatenation2)
        lblWelcome.attributedText = concatenation
        
        lblUser.frame = CGRect(x: 0, y: lblWelcome.frame.origin.y + (lblWelcome.frame.height * 1.7) , width: widthView/1.3, height: widthView/19)
        lblUser.center.x = widthView/2
        lblUser.text = "User:"
        lblUser.textColor = UIColor.white
        lblUser.textAlignment = .left
        lblUser.numberOfLines = 0
        lblUser.font = UIFont(name: "Poppins-Regular", size:  view.frame.width/22)
        
        txtUser.frame = CGRect(x: 0, y: lblUser.frame.origin.y + (lblUser.frame.height/1.2),  width: widthView/1.3, height: widthView/12)
        txtUser.center.x = self.view.frame.width/2
        txtUser.font = UIFont(name:"Poppins-Regular", size: view.frame.width/21)
        txtUser.delegate = self
        txtUser.keyboardType = UIKeyboardType.emailAddress
        txtUser.textColor = UIColor.white
        txtUser.backgroundColor = .clear
        txtUser.setBottomBorder()
        txtUser.autocorrectionType = .no
        txtUser.text = ""
        txtUser.autocapitalizationType = .none;
        txtUser.text = ""
        
        lblPass.frame = CGRect(x: 0, y: txtUser.frame.origin.y + (txtUser.frame.height * 2) , width: widthView/1.3, height: widthView/19)
        lblPass.center.x = widthView/2
        lblPass.text = "Password:"
        lblPass.textColor = UIColor.white
        lblPass.textAlignment = .left
        lblPass.numberOfLines = 0
        lblPass.font = UIFont(name: "Poppins-Regular", size:  view.frame.width/22)
        
        txtPass.frame = CGRect(x: txtUser.frame.origin.x, y: lblPass.frame.origin.y + (lblPass.frame.height/1.2),  width: widthView/1.3, height: widthView/12)
        //txtPass.center.x = self.view.frame.width/2
        txtPass.font = UIFont(name:"Poppins-Regular", size: view.frame.width/21)
        txtPass.delegate = self
        txtPass.keyboardType = UIKeyboardType.emailAddress
        txtPass.textColor = UIColor.white
        txtPass.backgroundColor = .clear
        txtPass.autocorrectionType = .no
        txtPass.isSecureTextEntry = true
        txtPass.setBottomBorder()
        txtPass.text = ""
        
        
        btnEye.frame = CGRect(x: self.view.frame.width/1.23, y: (self.txtPass.frame.origin.y), width: self.view.frame.width/14, height: self.view.frame.width/14)
        btnEye.setBackgroundImage(UIImage(named: "ver_contra"), for: .normal)
        btnEye.addTarget(self, action: #selector(ViewController.seePass(_:)), for: UIControl.Event.touchUpInside)
        
        
        btnSend.frame = CGRect(x:0, y: viewForm.frame.height - (txtPass.frame.origin.y + txtPass.frame.height + (widthView/7)), width: widthView/1.27, height: widthView/7)
        btnSend.center.x = viewForm.frame.width/2
        btnSend.layer.borderWidth = 0
        btnSend.backgroundColor = UIColor.darkGray
        btnSend.layer.cornerRadius = btnSend.frame.height/4
        let attributebtn2 = NSMutableAttributedString(string: "OK", attributes: [NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size:widthView/23)!, NSAttributedString.Key.foregroundColor : UIColor.white])
        btnSend.setAttributedTitle(attributebtn2, for: .normal)
        btnSend.addTarget(self, action: #selector(ViewController.sendLogin(_:)), for: UIControl.Event.touchUpInside)
        
        viewForm.addSubview(lblWelcome)
        viewForm.addSubview(lblUser)
        viewForm.addSubview(txtUser)
        viewForm.addSubview(lblPass)
        viewForm.addSubview(txtPass)
        viewForm.addSubview(btnEye)
        viewForm.addSubview(btnSend)
        
        self.view.addSubview(viewForm)
        
     
    }
    
    //MARK: Buttons Actions
    @objc func seePass(_ sender : AnyObject){
          if(txtPass.isSecureTextEntry){
              txtPass.isSecureTextEntry = false
          }else{
              txtPass.isSecureTextEntry = true
          }
      }
    
    
    @objc func sendLogin(_ sender : AnyObject){
        IJProgressView.shared.showProgressView(view: view)
        sendRequest()
    }
    
    func sendRequest() {
        let sesion = LoginRequest(user_: txtUser.text!, pass_: txtPass.text!)
        sesion.getLoguin{ [weak self] result  in
            switch result{
            case .failure(let error):
                print(error)
                Alert.Warning(delegate: self!, message: "Invalid User!")
                IJProgressView.shared.hideProgressView()
                break
            case .success(let dataLogin):
                print(dataLogin)
                IJProgressView.shared.hideProgressView()
                self!.performSegue(withIdentifier: "goHome", sender: self)
                break
            }
        }
       }
    
}

//MARK: Extensions Delegates
extension ViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true;
    }
}
