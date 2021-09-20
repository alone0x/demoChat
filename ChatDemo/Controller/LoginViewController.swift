//
//  LoginViewController.swift
//  ChatDemo
//
//  Created by thanhbt on 16/09/2021.
//

import UIKit
import Firebase
import FirebaseAuth
class LoginViewController: UIViewController {

    @IBOutlet weak var mailText: UITextField!
    @IBOutlet weak var PassWordText: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    // test signout
    
    override func viewWillAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            try!  Auth.auth().signOut()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        LoginButton.setupButton()
        // Do any additional setup after loading the view.
//        SampleLoginAPI(params: ["login_id": "hand", "password": "123456"]).execute { result in
//            switch result {
//            case .success(let response):
//                guard let data = response.data else {
//                    print("Error: No data")
//                    return
//                }
//                print(data.accessToken ?? "")
//                print(data.userId ?? "")
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
        
        SampleTodoAPI(id: 3).execute { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        SampleCreatePostAPI(params: ["title": "Ha", "body": "New body", "userId": 1001]).execute { result in
            switch result {
            case .success(let post):
                print(post)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func ForgotPasswordButton(_ sender: Any) {
    }
    
    @IBAction func LoginButton(_ sender: Any) {
    }
    
    @IBAction func RegisterButton(_ sender: Any) {
        if #available(iOS 13.0, *) {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "RegisterViewController") as! RegisterViewController
            navigationController?.pushViewController(vc, animated: true)
                                    } else {
            // Fallback on earlier versions
            }
    }
    
    @IBAction func LoginButtontap(_ sender: Any) {
        if let email = mailText.text, let password = PassWordText.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
              //guard let strongSelf = self else { return }
                if let _ = error {
                    print("dang nhap khong thanh cong")
                }
                if Auth.auth().currentUser != nil{
                    print("dang nhap thanh cong")
                }
            }
        }
    }
}

extension UIButton{
    func setupButton(){
        self.layer.cornerRadius = self.frame.height/2
    }
}
