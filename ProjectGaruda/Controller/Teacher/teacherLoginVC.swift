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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: UIButton) {

        
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (authResult, error) in
            if error != nil {
                print("Error signing in")
                print(error)
            } else {
                let uid = Auth.auth().currentUser!.uid
                self.teacher.parseInfo(uid)

                self.performSegue(withIdentifier: "loginSuccess", sender: self)
            }
        }
    }
}
