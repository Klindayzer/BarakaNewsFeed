//
//  HomeViewController.swift
//  BarakaTest
//
//  Created by Klindayzer on 27/04/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    private enum Values {
        static let title = "Baraka"
        static let viewBackground: UIColor = .white
    }
    
    private var viewModel: HomeViewModel?
    
    convenience init(viewModel: HomeViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        navigationItem.title = Values.title
        view.backgroundColor = Values.viewBackground
    }
}
