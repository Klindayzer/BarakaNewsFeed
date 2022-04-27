/*
 *	DateParsable.swift
 *	BarakaTest
 *
 *	Created by Klindayzer on 28/04/2022.
 */

protocol DateParsable {
    func parseContent<T>(from content: String, decodingType: T.Type) -> T?    
}
