//
//  ViewController.swift
//  BarakaTest
//
//  Created by Klindayzer on 27/04/2022.
//

import UIKit

class ViewController: UIViewController {
    
    private enum Values {
        static let title = "Baraka"
        static let viewBackground: UIColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        navigationItem.title = Values.title
        view.backgroundColor = Values.viewBackground
    }
}
