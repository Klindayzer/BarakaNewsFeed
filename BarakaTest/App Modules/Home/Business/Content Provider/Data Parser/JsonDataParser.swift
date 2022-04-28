/*
 *	JsonDataParser.swift
 *	BarakaTest
 *
 *	Created by Klindayzer on 28/04/2022.
 */

import Foundation

struct JsonDataParser: DataParsable {
    
    func parseContent<JSON: Codable>(from content: String, decodingType: JSON.Type) -> Any? {
        
        let jsonData = Data(content.utf8)
        let decoder = JSONDecoder()
        
        do {
            let json = try decoder.decode(decodingType.self, from: jsonData)
            return json
            
        } catch {
            return nil
        }
    }
}
