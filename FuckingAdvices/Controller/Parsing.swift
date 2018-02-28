//
//  Parsing.swift
//  FuckingAdvices
//
//  Created by admin on 27.02.2018.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Parsing: NSObject {
    static let sharedInstance = Parsing()
    let url: URL = URL(string: "http://fucking-great-advice.ru/api/random")!
    
    func loadData(completion: @escaping (_ success: Bool,_ jsonUser: Dictionary<String, Any>) -> Void) {
        //возвращаем формат Dictionary<String, Any>
        Alamofire.request(url).responseJSON { (response) in
            if response.result.value != nil {
                let json = JSON(response.result.value!)
                completion(true, json.rawValue as! Dictionary<String, Any>)
            }
        }
    }
}
