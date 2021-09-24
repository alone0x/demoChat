//
//  LoginViewController.swift
//  ChatDemo
//
//  Created by thanhbt on 16/09/2021.
//

import UIKit

class LoginViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var ScrollView: UIScrollView!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var HeaderView: UIView!
    
    @IBOutlet weak var BodyView: UIView!
    
    @IBOutlet weak var FooterVIew: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        LoginButton.setupButton()
        
//        if let scrollview =  ScrollView{
//        scrollview.contentSize = CGSize(width: scrollview.contentSize.width,height: scrollview.frame.size.height)
//        }
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
    
    @IBAction func forgotPass(_ sender: Any) {
    }
    
    @IBAction func registerAcountButton(_ sender: UIButton) {
        if #available(iOS 13.0, *) {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "RegisterViewController") as! RegisterViewController
            navigationController?.pushViewController(vc, animated: true)
        } else {
            // Fallback on earlier versions
        }
    }
}

extension UIButton {
    func setupButton() {
        self.layer.cornerRadius = self.frame.height/2
    }
}
