/*
 *	NSObject.swift
 *	BarakaTest
 *
 *	Created by Klindayzer on 29/04/2022.
 */

import Foundation

extension NSObject {
    
    static var name: String {
        return String(describing: self)
    }
}
