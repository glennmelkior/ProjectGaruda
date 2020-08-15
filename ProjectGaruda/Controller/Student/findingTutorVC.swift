//  findingTutorVC.swift
//  ProjectGaruda
//
//  Created by Glenn Melkior on 8/15/20.
//  Copyright © 2020 Glenn Melkior. All rights reserved.


import UIKit

class findingTutorVC: UIViewController {

    var user : UserData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func notifyMe(_ sender: UIButton) {
        user!.status = "notify"
        user!.update()
        
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        user!.status = "offline"
        user!.update()
        
        dismiss(animated: true, completion: nil)
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
