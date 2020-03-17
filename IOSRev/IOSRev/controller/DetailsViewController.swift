//
//  DetailsViewController.swift
//  IOSRev
//
//  Created by user on 24/01/2020.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit


class DetailsViewController: UIViewController {

    // MARK: - Instances
    static let shared = DetailsViewController()

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    var finalname = ""
    var finalprice = ""
    var final_id = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        print("finalname :",finalname)
        print("finalprice :",finalprice)
        print("final_id :",final_id)
       // print(name.text)
        //print(price.text)
        self.name.text = finalname
        self.price.text = finalprice
        
        
    
        // Do any additional setup after loading the view.
    }
    

    //MARK: - Update function
    @IBAction func update(_ sender: Any) {
       //putData(id: "5e2ea7b4241257031b947d0d",a: "one+2",c: "1100")
//        print(final_id)
//        let vc = PopupForUpdateViewController()
//        vc.id = self.final_id

//        func prepare(for segue: DetailsupSegue, sender: Any?){
//            if segue.destination is PopupForUpdateViewController {
//                let vc = segue.destination as? PopupForUpdateViewController
//                vc?.id = self.final_id
//            }
//        }
        
       print("upating data here")
        self.performSegue(withIdentifier: "DetailsupSegue", sender: self)
        print("final id in segue :",final_id)
    }
    // prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DetailsupSegue" {
            let vc = segue.destination as! PopupForUpdateViewController
        
            vc.id = final_id
        }
    }
    
    
    
    @IBAction func adding(_ sender: Any) {
        //postingData(a: "iphone7",c: "1300")
        
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:"StoryPopUpId") as! PopUPViewController
        
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
    }
    
    
    
    // MARK: - Delete
    @IBAction func deleting(_ sender: Any) {
        let alert = UIAlertController(title: "Do you want to delete?", message: "It's recommended you to make shure before goes on.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
        

            self.DeletingData(id: self.final_id)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
//        if(title == "YES") {
//            print("item is deleted")
//        }
        self.present(alert, animated: true)
        
    }
    
    // MARK: - POST
   func postingData(a : String , c : String) {
        
        let parameters = ["name": a, "price": c]
        
        //create the url with NSURL
        let url = URL(string: "http://localhost:1234/products/create")!
        
        //create the session object
        let session = URLSession.shared
        
        //now create the Request object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to data object and set it as request body
        } catch let error {
            print(error.localizedDescription)
            //completion(nil, error)
        }
        
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            
            guard error == nil else {
                //completion(nil, error)
                return
            }
            
            guard let data = data else {
                // completion(nil, NSError(domain: "dataNilError", code: -100001, userInfo: nil))
                return
            }
            
            do {
                //create json object from data
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                    //  completion(nil, NSError(domain: "invalidJSONTypeError", code: -100009, userInfo: nil))
                    return
                }
                print(json)
                // completion(json, nil)
            } catch let error {
                print(error.localizedDescription)
                // completion(nil, error)
            }
        })
        
        task.resume()
    }
    
    
    
    
    
    
    

    
    
    // MARK:- PUT
    func putData(id:String ,a : String , c : String){
        let url = URL(string: "http://localhost:1234/products/"+id+"/update")
    
        var request = URLRequest(url: url! as URL)
        request.httpMethod = "PUT"
        let parameters = ["name": a ,"price":c]
        
        
        print(parameters)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        }catch  {
            print(error)
        }
        let session = URLSession(configuration:URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
        let dataTask = session.dataTask(with: request) { (data, response, error) -> Void in
            
            
            if error != nil {
                print("we have a prob here")
                print(error!)
            }
            else {
                
                let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("Parsed JSON: '\(jsonStr)'")
            }
        }
        dataTask.resume()
    }
   
    func DeletingData(id : String){
        
        let url = URL(string: "http://localhost:1234/products/"+id+"/delete")
        var request = URLRequest(url: url! as URL)
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil { print(error!); return }
            do {
                if let jsonObj = try JSONSerialization.jsonObject(with: data!) as? String {
                    print(jsonObj)
                    
//                    DispatchQueue.main.async {
//                        self.V.reloadData()
//                    }
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    

}


enum APIError : Error {
    case responsePro
    case decodingPro
    case otherPro
}
