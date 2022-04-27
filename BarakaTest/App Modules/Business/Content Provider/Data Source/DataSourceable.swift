/*
 *	Repository.swift
 *	BarakaTest
 *
 *	Created by Klindayzer on 28/04/2022.
 */

typealias DataSourceCompletion = (String) -> Void

enum DataType: String {
    case json
    case csv
}

protocol DataSourceable {
    func readContent(from path: String, for type: DataType, completion: @escaping DataSourceCompletion)
}
