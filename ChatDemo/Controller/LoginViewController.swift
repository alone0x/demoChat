//
//  LoginViewController.swift
//  ChatDemo
//
//  Created by thanhbt on 16/09/2021.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var LoginButton: UIButton!
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
}

extension UIButton{
    func setupButton(){
        self.layer.cornerRadius = self.frame.height/2
    }
}
