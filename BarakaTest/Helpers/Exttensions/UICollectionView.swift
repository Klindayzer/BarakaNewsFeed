/*
 *	UICollectionView.swift
 *	BarakaTest
 *
 *	Created by Klindayzer on 29/04/2022.
 */

import UIKit

extension UICollectionView {

    func register<T>(cell: T.Type) {
        
        let identifier = String(describing: T.self)
        self.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
    
    func dequeue<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.name, for: indexPath) as? T else {
            fatalError("Unable to Dequeue Reusable Collection View Cell With Id \(T.name)")
        }
        return cell
    }

}
