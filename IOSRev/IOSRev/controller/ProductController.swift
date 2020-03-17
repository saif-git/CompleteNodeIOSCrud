//
//  ProductController.swift
//  IOSRev
//
//  Created by user on 23/01/2020.
//  Copyright © 2020 user. All rights reserved.
//

import Foundation
class Connexion {

    static let shared = Connexion()
    static  var data2 : [Product] = []
    var actors = [Product]()

    func fetchJSON()  {
        let urlString = "http://localhost:1234/products/"

        guard let url = URL(string: urlString)  else{ return        }
        
        URLSession.shared.dataTask(with: url) { (data, _, err) in
            if let err = err {
                print("Failed to fetch data from", err)
                return
            }
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let books = try decoder.decode([Product].self, from: data)
//                Connexion.data2 = books
//                            books.forEach({print($0.name)})
                self.actors = books
                Connexion.data2 = books
                //print("data :",books)
                
            } catch let jsonErr {
                print("Failed to parse json:", jsonErr)
            }
            }.resume()
    }
}

enum NetworkError : Error {
    case url
}

