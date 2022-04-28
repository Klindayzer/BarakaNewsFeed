/*
 *	Repository.swift
 *	BarakaTest
 *
 *	Created by Klindayzer on 28/04/2022.
 */

import Foundation
import RxSwift

enum DataType: String {
    case json
    case csv
}

protocol DataSourceable {
    func readContent(from url: URL, type: DataType) -> Observable<String>
}
