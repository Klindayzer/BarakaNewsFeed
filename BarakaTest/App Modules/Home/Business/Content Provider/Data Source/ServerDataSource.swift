/*
 *	ServerDataSource.swift
 *	BarakaTest
 *
 *	Created by Klindayzer on 28/04/2022.
 */

import Foundation
import RxSwift

enum ServerError: Error {
    case invalidUrl
    case invalidData
}

struct ServerDataSource : DataSourceable {
    
    private let urlSession: URLSession
    
    init() {
        urlSession = URLSession(configuration: .default)
    }
    
    func readContent(from url: URL, type: DataType) -> Observable<String> {
        
        return Observable.create { observer in
            
            let task = urlSession.dataTask(with: url) { (data, response, error) in
                
                DispatchQueue.main.async {
                    
                    if let error = error {
                        observer.onError(error)
                    } else if let data = data, let content = String(data: data, encoding: .utf8) {
                        observer.onNext(content)
                    } else {
                        observer.onError(ServerError.invalidData)
                    }
                    
                    observer.onCompleted()
                }
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
