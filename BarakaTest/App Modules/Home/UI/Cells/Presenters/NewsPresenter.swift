/*
 *	NewsPresenter.swift
 *	BarakaTest
 *
 *	Created by Klindayzer on 29/04/2022.
 */

struct NewsPresenter {

    let image: String
    let title: String
    let date: String
    let description: String

    init(news: News) {
        
        image = news.urlToImage ?? ""
        title = news.title ?? ""
        date = news.publishedAt?.components(separatedBy: "T").first ?? ""
        description = news.description ?? ""
    }
}