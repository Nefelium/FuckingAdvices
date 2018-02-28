//
//  FavoritesViewController.swift
//  FuckingAdvices
//
//  Created by admin on 26.02.2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var adviceArray = [AdviceModel]() //массив избранных советов
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        adviceArray.removeAll()
        adviceArray = ReadWriteFavoritesAdvice.sharedInstance.getAllAdvice()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adviceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesTableViewCell", for: indexPath) as! FavoritesTableViewCell
        let advice: AdviceModel = adviceArray[indexPath.row]
        cell.advice = advice //непосредственно записываем данные в ячейки
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            removeAdvice(indexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        }
    }
    
    // эту функцию я разместил здесь, а не например, в ReadWriteFavoritesAdvice, потому что она имеет дело с лейблом, а значит, относится к интерфейсу
    func removeAdvice(indexPath: IndexPath) { //удаляем совет из UserDefaults
        let defaults: UserDefaults = UserDefaults.standard
        let adv: AdviceModel = adviceArray[indexPath.row]
        var mutableDictionary: Dictionary = defaults.object(forKey: "advice") as! Dictionary<String, Any>
        mutableDictionary.removeValue(forKey: String(describing: adv.id))
        defaults.set(mutableDictionary, forKey: "advice")
        defaults.synchronize()
        self.adviceArray = ReadWriteFavoritesAdvice.sharedInstance.getAllAdvice()
    }

}
