//
//  DatabaseManager.swift
//  ChatDemo
//
//  Created by thanhbt on 21/09/2021.
//

import Foundation
import FirebaseDatabase

final class DatabaseManage{
    static var shared = DatabaseManage()
    private let database = Database.database().reference()
    func setUpDataBase(){
        database.child("user").setValue(["name":nil])
    }
}
