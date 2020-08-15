//  studentEnterCategoryVC.swift
//  ProjectGaruda
//
//  Created by Glenn Melkior on 8/15/20.
//  Copyright © 2020 Glenn Melkior. All rights reserved.


import UIKit
import Firebase

class studentRegistrationVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var subject: UIPickerView!
    @IBOutlet weak var topic: UITextField!
    @IBOutlet weak var details: UITextView!
    
    var user = UserData()
    var signInSuccess = false
    var ref: DatabaseReference!
    
    let subjects : [String] = ["English", "Math", "Humanities", "Biology", "Physics", "Chemistry"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        subject.delegate = self
        subject.dataSource = self
        
        ref = Database.database().reference()
        
        Auth.auth().signInAnonymously { (authResult, error) in
            if error != nil {
                print("Error signing in")
            } else {
                self.signInSuccess = true
                guard let resultUser = authResult?.user else { return }
                self.user.uid = resultUser.uid
            }
            
            
        }
        
        user.subject = subjects[0]
    }
    
    
    @IBAction func submit(_ sender: UIButton) {
        user.name = name.text!
        user.topic = topic.text!
        user.details = details.text!
        
        user.update()
        
        performSegue(withIdentifier: "findTutor", sender: self)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return subjects.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return subjects[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        user.subject = subjects[row]
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "findTutor" {
            let destinationVC = segue.destination as! findingTutorVC
            
            destinationVC.user = user
        }
    }
}
