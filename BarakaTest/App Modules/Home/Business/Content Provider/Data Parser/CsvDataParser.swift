/*
 *	CsvDataParser.swift
 *	BarakaTest
 *
 *	Created by Klindayzer on 28/04/2022.
 */

import Foundation
import CSV

struct CsvDataParser: DataParsable {
    
    func parseContent<JSON: Codable>(from content: String, decodingType: JSON.Type) -> Any? {
        
        var records = [JSON]()
        do {
            let reader = try CSVReader(string: content, hasHeaderRow: true, trimFields: true)
            let decoder = CSVRowDecoder()
            while reader.next() != nil {
                let row = try decoder.decode(decodingType.self, from: reader)
                records.append(row)
            }
            return records
        } catch {
            return nil
        }
    }
}
