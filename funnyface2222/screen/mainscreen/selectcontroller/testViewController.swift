//
//  testViewController.swift
//  funnyface2222
//
//  Created by quocanhppp on 15/01/2024.
//

import UIKit
import SETabView
class testViewController: UIViewController,SETabItemProvider {
    var seTabBarItem: UITabBarItem? {
        return UITabBarItem(title: "haha", image: UIImage(named: "notification"), tag: 0)
    }
    
    @IBOutlet weak var notiLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        notiLabel.font = .quickSandBold(size: 24)
        searchButton.setTitle("", for: .normal)
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
