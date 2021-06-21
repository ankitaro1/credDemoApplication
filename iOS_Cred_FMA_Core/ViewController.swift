//
//  ViewController.swift
//  iOS_Cred_FMA_Core
//
//  Created by Ankit sharma7 on 20/06/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var enterCrenButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.enterCrenButton.layer.borderWidth = CGFloat(1)
        self.enterCrenButton.layer.borderColor =  UIColor.white.cgColor
        self.enterCrenButton.layer.cornerRadius = CGFloat(12)
        self.navigationController?.navigationBar.isHidden = true
    }
    @IBAction func enterCredButtonPressed(_ sender: UIButton) {
        let targetVC = CredMainViewController()
        self.navigationController?.pushViewController(targetVC, animated: false)
    }
    

}

