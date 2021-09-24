//
//  DatabaseManager.swift
//  ChatDemo
//
//  Created by thanhbt on 21/09/2021.
//

import Foundation
import FirebaseFirestore

final class DatabaseManager {
    let database =  Firestore.firestore()
    static var shared = DatabaseManager()
    func writeData(text: String){
        let doc =  database.document("buitrungthanh/ex")
        doc.setData(["text": text])
    }
}
