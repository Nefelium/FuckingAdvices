//
//  AdviceViewController.swift
//  FuckingAdvices
//
//  Created by admin on 26.02.2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class AdviceViewController: UIViewController {
    
    static let access = AdviceViewController()
    
    var responseJSON = [AdviceModel]()
    
    @IBOutlet weak var AdviceLabel: UILabel!
    
    @IBAction func AddToFavoritesButton(_ sender: Any) {
         ReadWriteFavoritesAdvice.sharedInstance.saveAdvice(advice: self.responseJSON[0])
    }
    @IBAction func NextAdvice(_ sender: Any) {
        loadData()
    }
    
    func loadData() {
        Parsing.sharedInstance.loadData { (success, jsonAdvice) in
            if success {
                self.responseJSON.removeAll()
                self.responseJSON.append(AdviceModel(advice: jsonAdvice)) //записываем в масссив результат
                self.AdviceLabel.text = jsonAdvice["text"] as? String //и выводим на лейбл text из массива
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        // обновление совета каждые 30 сек
        let timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { (timer) in
            self.loadData()
        }
        RunLoop.current.add(timer, forMode: .commonModes)
    }

}
