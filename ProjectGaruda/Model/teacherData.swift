//  teacherData.swift
//  ProjectGaruda
//
//  Created by Glenn Melkior on 8/15/20.
//  Copyright © 2020 Glenn Melkior. All rights reserved.


import Foundation
import Firebase

class TeacherData {
    var name: String?
    var subject: String?
    var uid: String?
    var ref =  Database.database().reference()
    
    func update(){
        
        ref.child("teachers").child(uid!).setValue([
            "name": name!,
            "subject": subject!
        ])
    }
    
    func parseInfo(_ uid: String){
        
        ref.child("teachers").child(uid).observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.name = value?["name"] as? String
            self.subject = value?["subject"] as? String
            print(self.name)
            print(self.subject)
        }
        
    }
    
    
}
