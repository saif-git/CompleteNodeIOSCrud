//
//  PopUPViewController.swift
//  IOSRev
//
//  Created by user on 24/01/2020.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit

class PopUPViewController: UIViewController {

    var shared = DetailsViewController.shared
    
    @IBOutlet weak var namePoP: UITextField!
    @IBOutlet weak var titlePoP: UITextField!
    var nom = ""
    var prix = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addingPost(_ sender: Any) {
        print("adding data from here")
        shared.postingData(a: namePoP.text!,c: titlePoP.text!)
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
