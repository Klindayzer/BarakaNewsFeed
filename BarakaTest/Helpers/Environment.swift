/*
 *	Environment.swift
 *	BarakaTest
 *
 *	Created by Klindayzer on 27/04/2022.
 */

import Foundation

final class Environment {
    
    private enum Scheme: String {
        case development = "BarakaTest-Develop"
        case local = "BarakaTest-Local"
    }
    
    enum PropertyListKeys: String {
        case plistEntryKey = "Integration Specific Identifiers"
        case scheme = "UD_CURRENT_SCHEME_NAME"
        case stock = "UD_STOCK_PATH"
        case news = "UD_NEWS_PATH"
    }
    
    private lazy var pList: [String: Any] = {
        
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        
        guard let dict = dict[PropertyListKeys.plistEntryKey.rawValue] as? [String : Any] else {
            fatalError("Integration Identifiers not found")
        }
        
        return dict
    }()
    
    private init() {}
}

// MARK: - Exposed Methods
extension Environment {
    
    static let instance = Environment()
    
    var isLocal: Bool {
        value(for: .scheme) == Scheme.local.rawValue
    }
    
    func value(for key: PropertyListKeys) -> String {
        pList[key.rawValue] as? String ?? ""
    }
}
