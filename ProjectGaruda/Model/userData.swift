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
    var status: String? //"online" or  "notify" or "offline"
    var ref =  Database.database().reference()
    
    func update() {
        print(uid)
        ref.child("students").child(uid!).setValue([
            "name": name!,
            "subject": subject!,
            "topic": topic!,
            "details": details!,
            "status": status
        ])
    }
}





