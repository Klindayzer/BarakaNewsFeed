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
    private let datasource: DataSourceable
    private let newsParser: DataParsable
    private let stockParser: DataParsable
    private let disposeBag: DisposeBag
    private let environment: Environment
    
    // MARK: - Exposed Properties
    let news: BehaviorRelay<[News]> = BehaviorRelay(value: [])
    let stocks: BehaviorRelay<[Stock]> = BehaviorRelay(value: [])
    
    var newsUrl: URL? {
        
        let path = environment.value(for: .news)
        return environment.isLocal ? Bundle.main.url(forResource: path, withExtension: DataType.json.rawValue) : URL(string: path)
    }
    
    var stocksUrl: URL? {
        
        let path = environment.value(for: .stock)
        return environment.isLocal ? Bundle.main.url(forResource: path, withExtension: DataType.csv.rawValue) : URL(string: path)
    }
    
    // MARK: - Constructors
    init(datasource: DataSourceable, newsParser: DataParsable, stockParser: DataParsable) {
        
        self.datasource = datasource
        self.newsParser = newsParser
        self.stockParser = stockParser
        disposeBag = DisposeBag()
        environment = Environment.instance
    }
    
    // MARK: - Exposed Methods
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
        
        guard let newsModel = newsParser.parseContent(from: content, decodingType: NewsModel.self) as? NewsModel else {
            return
        }
        news.accept(newsModel.articles ?? [])
    }
    
    func parseStocks(_ content: String) {
        
        guard let stocks = stockParser.parseContent(from: content, decodingType: Stock.self) as? [Stock] else {
            return
        }
        self.stocks.accept(stocks)
    }
}
