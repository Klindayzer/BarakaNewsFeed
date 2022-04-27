/*
 *	JsonDataParser.swift
 *	BarakaTest
 *
 *	Created by Klindayzer on 28/04/2022.
 */

import Foundation

protocol JsonParsable: DateParsable {
    associatedtype JSON
}

struct JsonDataParser<JSON: Codable>: JsonParsable {
    
    func parseContent<T>(from content: String, decodingType: T.Type) -> T? {
        let jsonData = Data(content.utf8)
        let decoder = JSONDecoder()
        
        do {
            let json = try decoder.decode(JSON.self, from: jsonData)
            return json as? T
            
        } catch {
            return nil
        }
    }
}
