//
//  PopupForUpdateViewController.swift
//  IOSRev
//
//  Created by user on 27/01/2020.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit

class PopupForUpdateViewController: UIViewController {

    // MARK: - Instance from Details
    var shared = DetailsViewController.shared

    // MARK: - paramatre
    @IBOutlet weak var phoneUp: UITextField!
    @IBOutlet weak var priceUp: UITextField!
    var id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("id :",id)
        // Do any additional setup after loading the view.
    }
    

    // MARK: - Updating Data
    @IBAction func UpdatingData(_ sender: Any) {
        print("updating Any way")
        print("id : ",id)
        //shared.final_id
        shared.putData(id: id, a: phoneUp.text!, c: priceUp.text!)
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
