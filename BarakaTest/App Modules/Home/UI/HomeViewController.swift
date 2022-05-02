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
        case feturedNews = "FEATURED_NEWS"
        case normalNews = "NORMAL_NEWS"
    }
    
    private enum Values {
        static let title = "Baraka"
        static let viewBackground: UIColor = .white
        static let insets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
    }
    
    private var viewModel = HomeViewModel()
    private let disposeBag = DisposeBag()
    private var timer: Timer?
    private var dataSource: HomeDataSource?
    
    private lazy var collectionView: UICollectionView = {
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: setupCollectionViewLayout())
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = UIColor(named: "ivory")
        collectionView.delegate = self
        collectionView.register(cell: StockCell.self)
        collectionView.register(cell: FeaturedNewsCell.self)
        collectionView.register(cell: NormalNewsCell.self)
        return collectionView
    }()
    
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
        setupCollectionDataSource()
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
                
                let stocks = stocks.map {
                    StockPresenter(stock: $0)
                }
                
                let featuredNews = featuredNews.map {
                    NewsPresenter(news: $0)
                }
                
                let normalNews = normalNews.map {
                    NewsPresenter(news: $0)
                }
                self?.setupSnapshot(stocks: stocks, feturedNews: featuredNews, normalNews: normalNews)
                
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

// MARK: - UICollectionView Methods
extension HomeViewController {
    
    private func setupCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            var section: NSCollectionLayoutSection?
            
            switch HomeSections.allCases[sectionIndex] {
            case .stocks:
                section = self.generateStockSection()
                
            case .feturedNews:
                section = self.generateFeaturedNewsSection()
                
            case .normalNews:
                section = self.generateNormalNewsSection()
            }
            
            return section
        }
    }
    
    private func generateStockSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(140))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95), heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = Values.insets
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    private func generateFeaturedNewsSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.75), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = Values.insets
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    private func generateNormalNewsSection() -> NSCollectionLayoutSection? {
        
        let itemCount = viewModel.normalNews.value.count
        guard itemCount > 0 else { return nil }
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = Values.insets
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(CGFloat(200 * itemCount)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: itemCount)
        

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    func setupCollectionDataSource() {
        
        dataSource = HomeDataSource(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, item: AnyHashable) -> UICollectionViewCell? in
            
            let section = HomeSections.allCases[indexPath.section]
            switch section {
            case .stocks:
                
                guard let stock = item as? StockPresenter else {
                    return UICollectionViewCell()
                }
                let cell: StockCell = collectionView.dequeue(for: indexPath)
                cell.setupCell(with: stock)
                return cell
                
            case .feturedNews:
                guard let news = item as? NewsPresenter else {
                    return UICollectionViewCell()
                }
                let cell: FeaturedNewsCell = collectionView.dequeue(for: indexPath)
                cell.setupCell(with: news)
                return cell
                
            case .normalNews:
                guard let news = item as? NewsPresenter else {
                    return UICollectionViewCell()
                }
                let cell: NormalNewsCell = collectionView.dequeue(for: indexPath)
                cell.setupCell(with: news)
                return cell
            }
        }
    }
    
    func setupSnapshot(stocks: [StockPresenter], feturedNews: [NewsPresenter], normalNews: [NewsPresenter]) {
        
        var snapshot = NSDiffableDataSourceSnapshot<HomeSections, AnyHashable>()
        snapshot.appendSections([HomeSections.stocks])
        snapshot.appendItems(stocks)
        
        snapshot.appendSections([HomeSections.feturedNews])
        snapshot.appendItems(feturedNews)
        
        snapshot.appendSections([HomeSections.normalNews])
        snapshot.appendItems(normalNews)
        
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    
}
