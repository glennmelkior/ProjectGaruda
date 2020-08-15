//  teacherRegistrationVC.swift
//  ProjectGaruda
//
//  Created by Glenn Melkior on 8/15/20.
//  Copyright © 2020 Glenn Melkior. All rights reserved.


import UIKit
import Firebase
import ImagePicker

class teacherRegistrationVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, ImagePickerDelegate {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var subject: UIPickerView!
    @IBOutlet weak var previewID: UIImageView!
    
    var teacher = TeacherData()
    var storageRef = Storage.storage().reference()
    
    let imagePicker = ImagePickerController()
    let subjects : [String] = ["English", "Math", "Humanities", "Biology", "Physics", "Chemistry"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        imagePicker.imageLimit = 1
        
        subject.delegate = self
        subject.dataSource = self
        
        teacher.subject = subjects[0]
    }
    
    @IBAction func uploadID(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func submit(_ sender: UIButton) {
        teacher.name = name.text!
        teacher.status = "offline"
        
        let group = DispatchGroup()
        group.enter()
        
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (authResult, error) in
            if error != nil {
                print("Failed to create new teacher")
                print(error)
            } else {
                guard let resultTeacher = authResult?.user else { return }
                self.teacher.uid = resultTeacher.uid
                group.leave()
            }
        }
        
        let group2 = DispatchGroup()
        group2.enter()
        
        group.notify(queue: .main){
            self.teacher.update()
            group2.leave()
        }
        
        group2.notify(queue: .main){
            let userRef = self.storageRef.child(self.teacher.uid!)
            
            if let data = self.previewID.image?.jpegData(compressionQuality: 1.0){
                let photoRef = userRef.child("ID.jpg")
                
                let _ = photoRef.putData(data, metadata: nil) { (metadata, error) in
                    if error != nil {
                        print("Error uploading id")
                        print(error)
                    } else {
                        print("ID uploaded")
                    }
                }
            } else {
                print("compression failed")
            }
        }
        
        performSegue(withIdentifier: "registerSuccess", sender: self)
    }
    
    //MARK: - picker view
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
        teacher.subject = subjects[row]
    }

    //MARK: - imagePicker
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        
        previewID.image = images[0]
        
        dismiss(animated: true, completion: nil)
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

}
