//
//  ViewController.swift
//  IOSRev
//
//  Created by user on 23/01/2020.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
 
    @IBOutlet weak var tblList: UITableView!
   private var actors = [Product]()

    var nameText = ""
    var priceText = ""
    var result : [Product] = []
    var id : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        //fetchJSON()
        fetchJSON()
        tblList.dataSource = self
        tblList.delegate = self
        //actors = Connexion.data2
    }
    
    func fetchJSON()  {
        let urlString = "http://localhost:1234/products/"
        
        guard let url = URL(string: urlString)  else{ return  }
        
        URLSession.shared.dataTask(with: url) { (data, _, err) in
            if let err = err {
                print("Failed to fetch data from", err)
                return
            }
            guard let data = data else { return }
            print("data befor decoding :",data)
            do {
                let decoder = JSONDecoder()
                let books = try decoder.decode([Product].self, from: data)
                //                Connexion.data2 = books
                //                            books.forEach({print($0.name)})
                self.actors = books
               // print("data :",books)
                DispatchQueue.main.async {
                    self.tblList.reloadData()
                }
                
            } catch let jsonErr {
                print("Failed to parse json:", jsonErr)
            }
            }.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cellule") as? productCell else { return UITableViewCell() }
        cell.name.text = actors[indexPath.row].name
        
        return cell
    }
    

     func tableView(_ tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String?{
        return "Operation Start From Here"
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         print("selected row path :",indexPath.row)
        nameText =  actors[indexPath.row].name
        priceText = String(actors[indexPath.row].price)
        id = actors[indexPath.row]._id
        performSegue(withIdentifier: "dataPass", sender: self)
        
//        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
//
//        let secondView = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
//        secondView.finalname = actors[indexPath.row].name
//        secondView.finalprice = String(actors[indexPath.row].price)
//        secondView.present(secondView,animated: true,completion: nil)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetailsViewController
        let index = tblList.indexPathForSelectedRow?.row
        vc.finalname = actors[index ?? 0].name
        vc.finalprice = String(actors[index ?? 0].price)
        vc.final_id = actors[index ?? 0]._id
    }
}

