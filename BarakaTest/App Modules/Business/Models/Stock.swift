/*
 *	Stock.swift
 *	BarakaTest
 *
 *	Created by Klindayzer on 27/04/2022.
 */

struct Stock: Codable {
    
    let stock: String?
    let price: String?
    
    enum CodingKeys: String, CodingKey {
        case stock = "STOCK"
        case price = "PRICE"            
    }
}
