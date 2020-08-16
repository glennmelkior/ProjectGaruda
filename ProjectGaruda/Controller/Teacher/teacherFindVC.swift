//  teachMenuVC.swift
//  ProjectGaruda
//
//  Created by Glenn Melkior on 8/16/20.
//  Copyright © 2020 Glenn Melkior. All rights reserved.


import UIKit
import Firebase

class teacherFindVC: UIViewController {

    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var numberOnline: UILabel!
    
    var teacher: TeacherData?
    var uid: String?
    var subject: String?
    var number: Int?
    var name: String?
    
    var ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let group = DispatchGroup()
        group.enter()
        
        if teacher == nil {
            let newTeacher = TeacherData()
            newTeacher.parseInfo(uid!) { (teacherResult) in
                self.subject = teacherResult!.subject
                group.leave()
            }
            teacher = newTeacher
        } else {
            self.subject = teacher?.subject
        }
        
        group.notify(queue: .main){
            self.teacher?.getNumberOfStudents(self.subject!, completion: { (numResult) in
                self.number = Int(truncating: numResult! as NSNumber)
                self.numberOnline.text = "\(self.number!) Students online"
            })
            self.subjectLabel.text = self.subject
        }
    }
    
    @IBAction func teach(_ sender: UIButton) {
//        if(number! > 0) {
//            ref.child("students").child(subject!).observe(.value, with: { (snapshot) in
//
//
//                for child in snapshot.children  {
//                    let value = child.value as? NSDictionary
//
//                    print(value)
//                    self.name = value?["name"] as? String
//                    print(self.name)
//
//                    break
//                }
//            })
//        }
//        unable to get name of student from database
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
