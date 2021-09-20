//
//  RegisterViewController.swift
//  ChatDemo
//
//  Created by thanhbt on 16/09/2021.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController {
    @IBOutlet weak var NameText: UITextField!
     
    @IBOutlet weak var EmailTetxt: UITextField!
    @IBOutlet weak var PassWordText: UITextField!
    @IBOutlet weak var ButtonSignup: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        ButtonSignup.setupButton()
//        FirebaseAuth.Auth.auth().signIn(withEmail: "", password: <#T##String#>, completion: <#T##((AuthDataResult?, Error?) -> Void)?##((AuthDataResult?, Error?) -> Void)?##(AuthDataResult?, Error?) -> Void#>)
//        // Do any additional setup after loading the view.
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    @IBAction func BackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func RegisterButton(_ sender: Any) {
        if let email = EmailTetxt.text , let password = PassWordText.text{
        Auth.auth().createUser(withEmail: email , password: password) {[weak self] rerult, Error in
            guard let self =  self else {
                return
            }
            print("da dang ki")
        }
        }
    //    FirebaseAuth.Auth.auth().signIn(withEmail: "", password: <#T##String#>, completion: <#T##((AuthDataResult?, Error?) -> Void)?##((AuthDataResult?, Error?) -> Void)?##(AuthDataResult?, Error?) -> Void#>)
        
    }
    @IBAction func LogginButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

}
