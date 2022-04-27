/*
 *	JsonDataParser.swift
 *	BarakaTest
 *
 *	Created by Klindayzer on 28/04/2022.
 */

import Foundation

struct JsonDataParser<JSON: Codable>: DataParsable {
    
    func parseContent(from content: String) -> Any? {
        
        let jsonData = Data(content.utf8)
        let decoder = JSONDecoder()
        
        do {
            let json = try decoder.decode(JSON.self, from: jsonData)
            return json
            
        } catch {
            return nil
        }
    }
}
