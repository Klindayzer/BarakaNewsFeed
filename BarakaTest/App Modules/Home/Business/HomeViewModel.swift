/*
 *	HomeViewModel.swift
 *	BarakaTest
 *
 *	Created by Klindayzer on 29/04/2022.
 */

// MARK: - Definitions

// MARK: - Type
import RxSwift

final class HomeViewModel {
    
    // MARK: - Properties
    private let datasource: DataSourceable
    private let newsParser: DataParsable
    private let stockParser: DataParsable
    
    // MARK: - Constructors
    init(datasource: DataSourceable,
         newsParser: DataParsable,
         stockParser: DataParsable) {
        
        self.datasource = datasource
        self.newsParser = newsParser
        self.stockParser = stockParser
    }
    
    // MARK: - Exposed Methods
    func fetchData(using newsPath: String, and stockPath: String) {
        
    }
}

// MARK: - Protected Methods
private extension HomeViewModel {
    
    func fetchNews(from path: String) {
        
        datasource.readContent(from: path, for: .json) { content in
            
        }
    }
    
    func fetchStocks(from path: String) {
        
        datasource.readContent(from: path, for: .csv) { content in
            
        }
    }
    
    func parseNews(_ content: String) -> [News] {
        
        let newsModel = newsParser.parseContent(from: content, decodingType: NewsModel.self) as? NewsModel
        return newsModel?.articles ?? []
    }
    
    func parseStocks(_ content: String) -> [Stock] {
        stockParser.parseContent(from: content, decodingType: Stock.self) as? [Stock] ?? []
    }
}
