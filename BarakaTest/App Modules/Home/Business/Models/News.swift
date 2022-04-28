/*
 *	News.swift
 *	BarakaTest
 *
 *	Created by Klindayzer on 27/04/2022.
 */

struct NewsModel: Codable {
    
    let status: String?
    let totalResults: Int?
    let articles: [News]?
}

struct News: Codable {
        
    let author, title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    let source: NewsSource?
}

struct NewsSource: Codable {
    
    let id: String?
    let name: String?
}
