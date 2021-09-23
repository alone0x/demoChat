//
//  extension.swift
//  ChatDemo
//
//  Created by thanhbt on 21/09/2021.
//

import Foundation
import UIKit

extension UIButton{
    func setupButton(){
        self.layer.cornerRadius = self.frame.height/2
    }
}

extension UIView{
    func setCorner(size : CGFloat){
        self.layer.cornerRadius = size
    }
}
