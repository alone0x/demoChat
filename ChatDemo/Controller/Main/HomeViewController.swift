//
//  HomeViewController.swift
//  ChatDemo
//
//  Created by thanhbt on 21/09/2021.
//

import UIKit
import FirebaseDatabase
class HomeViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var TabbarView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var nummberMess: UIView!
    @IBOutlet weak var CollectionviewContent: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        TabbarView.setCorner(size: 25)
        //nummberMess.setCorner(size: nummberMess.frame.width/2)
        nummberMess.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        CollectionviewContent.setCorner(size: 30)
        searchView.setCorner(size: searchView.frame.height/2)
        // Do any additional setup after loading the view.
    }

    @IBAction func ButtonTabbar(_ sender: UIButton) {
        let tag = sender.tag
        print(tag)
        if tag == 1{
            if #available(iOS 13.0, *) {
                let Home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "HomeViewController") as! HomeViewController
                contentView.addSubview(Home.view)
                Home.didMove(toParent: self)
                
            } else {
                // Fallback on earlier versions
            }
        }
        if tag == 2{
            if #available(iOS 13.0, *) {
                let FriendVC = UIStoryboard(name: "Friends", bundle: nil).instantiateViewController(identifier: "FriendsViewController") as! FriendsViewController
                contentView.addSubview(FriendVC.view)
                FriendVC.didMove(toParent: self)
                
            } else {
                // Fallback on earlier versions
            }
        }
        if tag == 3{
            if #available(iOS 13.0, *) {
                let FriendVC = UIStoryboard(name: "Friends", bundle: nil).instantiateViewController(identifier: "FriendsViewController") as! FriendsViewController
                contentView.addSubview(FriendVC.view)
                FriendVC.didMove(toParent: self)
                
            } else {
                // Fallback on earlier versions
            }
        }
    }
}
