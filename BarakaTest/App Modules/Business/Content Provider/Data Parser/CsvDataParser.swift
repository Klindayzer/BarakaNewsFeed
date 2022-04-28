/*
 *	CsvDataParser.swift
 *	BarakaTest
 *
 *	Created by Klindayzer on 28/04/2022.
 */

import Foundation
import CSV

struct CsvDataParser<JSON: Codable>: DataParsable {
    
    func parseContent(from content: String) -> Any? {
        
        var records = [JSON]()
        do {
            let reader = try CSVReader(string: content, hasHeaderRow: true, trimFields: true)
            let decoder = CSVRowDecoder()
            while reader.next() != nil {
                let row = try decoder.decode(JSON.self, from: reader)
                records.append(row)
            }
            return records
        } catch {
            return nil
        }
    }
}
