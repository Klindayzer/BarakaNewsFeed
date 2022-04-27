/*
 *	Repository.swift
 *	BarakaTest
 *
 *	Created by Klindayzer on 28/04/2022.
 */


typealias DataSourceCompletion = (String) -> Void

protocol DataSourceable {
    func readContent(from path: String, for type: String, completion: @escaping DataSourceCompletion)
}
