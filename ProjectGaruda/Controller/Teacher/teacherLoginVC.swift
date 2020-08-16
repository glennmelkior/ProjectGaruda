//  teacherLoginVC.swift
//  ProjectGaruda
//
//  Created by Glenn Melkior on 8/16/20.
//  Copyright © 2020 Glenn Melkior. All rights reserved.


import UIKit
import Firebase

class teacherLoginVC: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var ref = Database.database().reference()
    var teacher = TeacherData()
    var uid: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: UIButton) {
        
        let group = DispatchGroup()
        group.enter()
        
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (authResult, error) in
            if error != nil {
                print("Error signing in")
                print(error)
            } else {
                self.uid = Auth.auth().currentUser!.uid
                group.leave()
            }
        }
        
        group.notify(queue: .main){
            self.performSegue(withIdentifier: "loginSuccess", sender: self)

        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginSuccess" {
            let destinationVC = segue.destination as! teacherFindVC
            
            destinationVC.uid = self.uid
//            self.teacher.parseInfo(uid!) { (teacherResult) in
//                destinationVC.teacher = teacherResult
//            }
        }
    }
}
