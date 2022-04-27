/*
 *	LocalDataSource.swift
 *	BarakaTest
 *
 *	Created by Klindayzer on 28/04/2022.
 */

import Foundation

struct LocalDataSource: DataSourceable {
    
    func readContent(from path: String, for type: String, completion: @escaping DataSourceCompletion) {
        
        guard let filePath = Bundle.main.path(forResource: path, ofType: type) else {
            completion("")
            return
        }
        
        do {
            let content = try String(contentsOfFile: filePath)
            completion(content)
        
        } catch {
            completion("")
        }
    }
}
