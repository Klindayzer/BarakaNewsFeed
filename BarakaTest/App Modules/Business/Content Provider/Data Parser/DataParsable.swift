/*
 *	DateParsable.swift
 *	BarakaTest
 *
 *	Created by Klindayzer on 28/04/2022.
 */

protocol DataParsable {
    associatedtype JSON
    
    func parseContent(from content: String) -> Any?
}
