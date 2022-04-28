//
//  HomeViewController.swift
//  BarakaTest
//
//  Created by Klindayzer on 27/04/2022.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {
    
    private enum Values {
        static let title = "Baraka"
        static let viewBackground: UIColor = .white
    }
    
    private var viewModel: HomeViewModel?
    private let disposeBag = DisposeBag()
    
    convenience init(viewModel: HomeViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = Values.title
        view.backgroundColor = Values.viewBackground
        
        setupNewsObserver()
        setupStocksObserver()
        fetchData()
    }
}

// MARK: - Datasource Methods
private extension HomeViewController {
    
    func setupNewsObserver() {
        
        viewModel?.news.asObservable()
            .subscribe(onNext: { [weak self] news in
                print(news)
            })
            .disposed(by: disposeBag)
    }
    
    func setupStocksObserver() {
        
        viewModel?.stocks.asObservable()
            .subscribe(onNext: { [weak self] stoks in
                print(stoks)
            })
            .disposed(by: disposeBag)
    }
    
    func fetchData() {
        
        if let newsUrl = viewModel?.newsUrl,
           let stocksUrl = viewModel?.stocksUrl {
            
            viewModel?.fetchData(news: newsUrl, stocks: stocksUrl)
        }
    }
}
