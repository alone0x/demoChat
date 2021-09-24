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
    //private var database = Database.database().reference()
    // test signout
    
    override func viewWillAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            try!  Auth.auth().signOut()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        LoginButton.setupButton()
//        let object : [String : Any] = [
//            "name" : "bui trung thanh" as NSObject
//        ]
//        database.child("Something").setValue(object)
//
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
    
    func showAlert(mes : String) {
        let alert = UIAlertController(title: "Thông báo", message: mes, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: { UIAlertAction in
            print("cancel")
        }))
        present(alert, animated: true)
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
        DispatchQueue.main.async {
            self.LoginButton.isEnabled = false
            self.LoginButton.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
        
        if let email = mailText.text, let password = PassWordText.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
              //guard let strongSelf = self else { return }
                if let _ = error {
                    self?.LoginButton.isEnabled = true
                    self?.LoginButton.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
                    self?.showAlert(mes: "Lỗi! Hãy đăng nhập lại")
                }
                if Auth.auth().currentUser != nil {
                    //self?.showAlert(mes: "Đăng nhập thành công")
                    if #available(iOS 13.0, *) {
                        let homeVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "HomeViewController") as! HomeViewController
                        self?.navigationController?.pushViewController(homeVc, animated: true)
                        
                    } else {
                        // Fallback on earlier versions
                    }
                }
            }
        }
    }
}

