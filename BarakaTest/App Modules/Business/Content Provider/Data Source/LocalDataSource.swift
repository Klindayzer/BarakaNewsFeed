/*
 *	LocalDataSource.swift
 *	BarakaTest
 *
 *	Created by Klindayzer on 28/04/2022.
 */

import Foundation

struct LocalDataSource: DataSourceable {
    
    func readContent(from path: String, for type: DataType, completion: @escaping DataSourceCompletion) {
        
        guard let filePath = Bundle.main.path(forResource: path, ofType: type.rawValue) else {
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
