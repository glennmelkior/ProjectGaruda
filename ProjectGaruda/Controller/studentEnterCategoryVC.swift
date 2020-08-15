//  studentEnterCategoryVC.swift
//  ProjectGaruda
//
//  Created by Glenn Melkior on 8/15/20.
//  Copyright © 2020 Glenn Melkior. All rights reserved.


import UIKit
import DropDown

class studentEnterCategoryVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var subject: UIPickerView!
    @IBOutlet weak var topic: UITextField!
    @IBOutlet weak var details: UITextView!
    
    var user = UserData()
    
    let subjects : [String] = ["English", "Math", "Humanities", "Biology", "Physics", "Chemistry"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        subject.delegate = self
        subject.dataSource = self
    }
    
    
    @IBAction func submit(_ sender: UIButton) {
        user.name = name.text!
        user.topic = topic.text!
        user.details = details.text!
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
