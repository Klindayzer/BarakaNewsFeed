//
//  HomeViewController.swift
//  BarakaTest
//
//  Created by Klindayzer on 27/04/2022.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {
    
    private typealias HomeDataSource = UICollectionViewDiffableDataSource<HomeSections, AnyHashable>
    
    private enum HomeSections: String, CaseIterable {
        case stocks = "STOCKS"
    }
    
    private enum Values {
        static let title = "Baraka"
        static let viewBackground: UIColor = .white
    }
    
    private var viewModel = HomeViewModel()
    private let disposeBag = DisposeBag()
    private var timer: Timer?
    
    convenience init(viewModel: HomeViewModel) {
        self.init()
        
        self.viewModel = viewModel
        timer = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = Values.title
        view.backgroundColor = Values.viewBackground
        
        setupDataObserver()
        fetchData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        randomUpdateStocks()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer?.invalidate()
        timer = nil
    }
}

// MARK: - Datasource Methods
private extension HomeViewController {
    
    func setupDataObserver() {
        
        Observable.combineLatest(viewModel.currentStocks, viewModel.featuredNews, viewModel.normalNews)
            .subscribe(onNext: { [weak self] stocks, featuredNews, normalNews in
                print(stocks)
            }).disposed(by: disposeBag)
    }
    
    func fetchData() {
        
        if let newsUrl = viewModel.newsUrl,
           let stocksUrl = viewModel.stocksUrl {
            
            viewModel.fetchData(news: newsUrl, stocks: stocksUrl)
        }
    }
    
    func randomUpdateStocks() {
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
            
            guard let self = self else { return }
            self.viewModel.currentStocks.accept(self.viewModel.randomStocks())
        })
    }
}
