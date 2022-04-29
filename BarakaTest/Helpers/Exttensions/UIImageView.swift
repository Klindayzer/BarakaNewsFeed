/*
 *	UIImageView.swift
 *	BarakaTest
 *
 *	Created by Klindayzer on 29/04/2022.
 */

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(url: String?) {
       
        let url = URL(string: url ?? "")
        KF.url(url)
            .placeholder(UIImage(named: "placeholder"))
            .loadDiskFileSynchronously()
            .fade(duration: 0.25)
            .set(to: self)
    }
}
