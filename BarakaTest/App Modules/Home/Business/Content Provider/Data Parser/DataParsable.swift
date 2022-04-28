/*
 *	DateParsable.swift
 *	BarakaTest
 *
 *	Created by Klindayzer on 28/04/2022.
 */

protocol DataParsable {
    func parseContent<JSON: Codable>(from content: String, decodingType: JSON.Type) -> Any?
}
