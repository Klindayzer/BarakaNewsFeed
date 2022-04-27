/*
 *	ServerDataSource.swift
 *	BarakaTest
 *
 *	Created by Klindayzer on 28/04/2022.
 */

import Foundation

struct ServerDataSource : DataSourceable {
    
    func readContent(from path: String, for type: String, completion: @escaping DataSourceCompletion) {
        
        guard let url = URL(string: path) else {
            completion("")
            return
        }
        
        let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
            guard let data = data, let content = String(data: data, encoding: .utf8) else {
                completion("")
                return
            }
            
            completion(content)
        }
        urlSession.resume()
    }
}
