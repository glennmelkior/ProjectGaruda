//  UserInfo.swift
//  ProjectGaruda
//
//  Created by Glenn Melkior on 8/15/20.
//  Copyright © 2020 Glenn Melkior. All rights reserved.


import Foundation
import Firebase

struct UserData {
    var name: String?
    var subject: String?
    var topic: String?
    var details: String?
    var uid : String?
//    var status: String? //"online" or  "notify" or "offline"
    var ref =  Database.database().reference()
    
    func update() {
        ref.child("students").child(subject!).child(uid!).setValue([
            "name": name!,
            "topic": topic!,
            "details": details!,
            "subject": subject!
        ])
    }
    
    func delete(){
        ref.child("students").child(subject!).child(uid!).removeValue()
        
        let user = Auth.auth().currentUser
        user?.delete(completion: { (error) in
            if error != nil {
                print("Cannot delete user")
            } else {
                print("User deleted")
            }
        })
    }
}





