/*
 *	Stock.swift
 *	BarakaTest
 *
 *	Created by Klindayzer on 27/04/2022.
 */

struct Stock: Codable {
    
    let title: String?
    let price: String?
    
    init(title: String, price: String) {
        
        self.title = title
        self.price = price
    }
    
    enum CodingKeys: String, CodingKey {
        case title = "STOCK"
        case price = "PRICE"            
    }
}
