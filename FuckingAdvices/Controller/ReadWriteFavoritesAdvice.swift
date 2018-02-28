//
//  SaveData.swift
//  FuckingAdvices
//
//  Created by admin on 28.02.2018.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import UIKit


class ReadWriteFavoritesAdvice: NSObject {
    static let sharedInstance = ReadWriteFavoritesAdvice()
   
    // здесь мы сохраняем и получаем объекты из UserDefaults
    func saveAdvice(advice: AdviceModel) {
        let defaults: UserDefaults = UserDefaults.standard
        let codedAdvice: Data = NSKeyedArchiver.archivedData(withRootObject: advice)
        
        if defaults.object(forKey: "advice") == nil {
            let dictionary: Dictionary = [String(describing: advice.id) : codedAdvice]
            defaults.set(dictionary, forKey: "advice")
            defaults.synchronize()
        } else {
            var mutableDictionary: Dictionary = defaults.object(forKey: "advice") as! Dictionary<String, Any>
            mutableDictionary[String(describing: advice.id)] = codedAdvice
            defaults.set(mutableDictionary, forKey: "advice")
            defaults.synchronize()
        }
    }
    
    func getAllAdvice() -> Array<AdviceModel> {
        let defaults: UserDefaults = UserDefaults.standard
        if let dictionary: NSDictionary = defaults.object(forKey: "advice") as? NSDictionary {
            //проверочная инициализация, на случай, если мы запускаем программу впервые
            var array = [AdviceModel]()
            
            dictionary.enumerateKeysAndObjects { (key, obj, stop) in // собираем все объекты из UserDefaults
                let advice: AdviceModel = NSKeyedUnarchiver.unarchiveObject(with: obj as! Data) as! AdviceModel
                array.append(advice)
            }
            return array
        }
        return []
    }
    
}

