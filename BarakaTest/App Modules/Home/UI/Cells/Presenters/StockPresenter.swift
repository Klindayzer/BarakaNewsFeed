/*
 *	StockPresenter.swift
 *	BarakaTest
 *
 *	Created by Klindayzer on 29/04/2022.
 */
import UIKit

struct StockPresenter: HomeCellPresentable {

    let title: String
    let price: String
    let priceColor: UIColor
    
    init(stock: Stock) {
        
        title = stock.title ?? ""
        
        let stringPrice = stock.price?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let doublePrice = Double(stringPrice) ?? 0
        price = "\(String(format: "%.2f", doublePrice)) USD"
        
        let colorName = doublePrice > 0 ? "shineGreen120" : "persianPink"
        priceColor = UIColor(named: colorName) ?? .black
    }
}
