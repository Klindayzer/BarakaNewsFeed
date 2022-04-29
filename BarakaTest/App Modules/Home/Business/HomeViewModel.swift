/*
 *	HomeViewModel.swift
 *	BarakaTest
 *
 *	Created by Klindayzer on 29/04/2022.
 */

// MARK: - Definitions

// MARK: - Type
import Foundation
import RxSwift
import RxRelay

final class HomeViewModel {
    
    // MARK: - Protected Properties
    private let featuredNewsCount = 6
    private let datasource: DataSourceable
    private let newsParser: DataParsable
    private let stockParser: DataParsable
    private let disposeBag: DisposeBag
    private let environment: Environment
    private var stocks: [Stock]
    
    // MARK: - Exposed Properties
    let featuredNews: BehaviorRelay<[News]> = BehaviorRelay(value: [])
    let normalNews: BehaviorRelay<[News]> = BehaviorRelay(value: [])
    let currentStocks: BehaviorRelay<[Stock]> = BehaviorRelay(value: [])
    
    var newsUrl: URL? {
        
        let path = environment.value(for: .news)
        return environment.isLocal ? Bundle.main.url(forResource: path, withExtension: DataType.json.rawValue) : URL(string: path)
    }
    
    var stocksUrl: URL? {
        
        let path = environment.value(for: .stock)
        return environment.isLocal ? Bundle.main.url(forResource: path, withExtension: DataType.csv.rawValue) : URL(string: path)
    }
    
    // MARK: - Constructors
    init(datasource: DataSourceable = ServerDataSource(),
         newsParser: DataParsable = JsonDataParser(),
         stockParser: DataParsable = CsvDataParser()) {
        
        self.datasource = datasource
        self.newsParser = newsParser
        self.stockParser = stockParser
        disposeBag = DisposeBag()
        environment = Environment.instance
        stocks = []
    }
}

// MARK: - Exposed Methods
extension HomeViewModel {
    
    func fetchData(news: URL, stocks: URL) {
        
        Observable.combineLatest(fetchNews(from: news), fetchStocks(from: stocks))
            .subscribe { [weak self] newsContent, stocksContent in
                self?.parseNews(newsContent)
                self?.parseStocks(stocksContent)
                
            } onError: { error in
                print(error.localizedDescription)
                
            }
            .disposed(by: disposeBag)
    }
    
    func randomStocks() -> [Stock] {
        
        Dictionary(grouping: stocks, by: { $0.title }).compactMap({
            
            let stocks = $0.value
            guard let key = $0.key, !stocks.isEmpty else { return nil }
            let randomInt = Int.random(in: 0..<stocks.count)
            return Stock(title: key, price: stocks[randomInt].price ?? "")
        })
    }
}

// MARK: - Protected Methods
private extension HomeViewModel {
    
    func fetchNews(from url: URL) -> Observable<String> {
        datasource.readContent(from: url, type: .json)
    }
    
    func fetchStocks(from url: URL) -> Observable<String> {
        datasource.readContent(from: url, type: .csv)
    }
    
    func parseNews(_ content: String) {
        
        guard let newsModel = newsParser.parseContent(from: content, decodingType: NewsModel.self) as? NewsModel,
              let news = newsModel.articles else { return }
        
        let featuredNews = Array(news.prefix(featuredNewsCount))
        self.featuredNews.accept(featuredNews)
        
        let normalNews = featuredNewsCount <= news.count ? Array(news.suffix(from: featuredNewsCount)) : []
        self.normalNews.accept(normalNews)
    }
    
    func parseStocks(_ content: String) {
        
        guard let stocks = stockParser.parseContent(from: content, decodingType: Stock.self) as? [Stock] else {
            return
        }
        
        self.stocks = stocks
        let randomStoks = randomStocks()
        currentStocks.accept(randomStoks)
    }
}
