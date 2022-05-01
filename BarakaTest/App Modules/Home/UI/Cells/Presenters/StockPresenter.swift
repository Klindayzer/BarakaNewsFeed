/*
 *	StockPresenter.swift
 *	BarakaTest
 *
 *	Created by Klindayzer on 29/04/2022.
 */
import UIKit

class StockPresenter: Hashable {
    
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
    
    static func == (lhs: StockPresenter, rhs: StockPresenter) -> Bool {
        lhs.title == rhs.title
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(UUID().uuidString)
    }
}
