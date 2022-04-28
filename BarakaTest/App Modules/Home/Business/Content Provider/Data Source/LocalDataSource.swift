/*
 *	LocalDataSource.swift
 *	BarakaTest
 *
 *	Created by Klindayzer on 28/04/2022.
 */

import Foundation
import RxSwift

struct LocalDataSource: DataSourceable {
    
    func readContent(from url: URL, type: DataType) -> Observable<String> {
        
        return Observable.create { observer in
        
            do {
                let content = try String(contentsOf: url)
                observer.onNext(content)
            
            } catch let error {
                observer.onError(error)
            }
            return Disposables.create {}
        }
    }
}
