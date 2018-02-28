//
//  AdviceModel.swift
//  FuckingAdvices
//
//  Created by admin on 27.02.2018.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation

class AdviceModel: NSObject, NSCoding { // NSCoding - потому что мы будем работать с UserDefaults
    var id: Int? 
    var text: String?
    var sound: String?
    
    init(advice: [AnyHashable:Any]) {
        id = advice["id"] as? Int
        text = advice["text"] as? String
        sound = advice["sound"] as? String
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "id") as? Int
        self.text = aDecoder.decodeObject(forKey: "text") as? String
        self.sound = aDecoder.decodeObject(forKey: "sound") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.text, forKey: "text")
        aCoder.encode(self.sound, forKey: "sound")
    }
}
