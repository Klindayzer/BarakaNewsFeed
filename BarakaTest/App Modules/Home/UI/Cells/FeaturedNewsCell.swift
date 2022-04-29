/*
 *	FeaturedNewsCell.swift
 *	BarakaTest
 *
 *	Created by Klindayzer on 29/04/2022.
 */

import UIKit

final class FeaturedNewsCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var newsImageView: UIImageView!
    @IBOutlet private weak var newsTitleLabel: UILabel!
    @IBOutlet private weak var dimmingView: UIView!
    
   
    // MARK: - Exposed Methods
    func setupCell(with news: NewsPresenter) {
        
        dimmingView.backgroundColor = (UIColor(named: "black100") ?? .black).withAlphaComponent(0.6)
        
        newsImageView.setImage(url: news.image)
        newsTitleLabel.text = news.title
    }
}
