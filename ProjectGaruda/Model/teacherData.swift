//  teacherData.swift
//  ProjectGaruda
//
//  Created by Glenn Melkior on 8/15/20.
//  Copyright © 2020 Glenn Melkior. All rights reserved.


import Foundation
import Firebase

struct TeacherData {
    var name: String?
    var subject: String?
    var status: String? //"online" or "offline"
    var uid: String?
    var ref =  Database.database().reference()
    
    func update(){
        print(uid)
        ref.child("teachers").child(uid!).setValue([
            "name": name!,
            "subject": subject!,
            "status": status!
        ])
    }
}
