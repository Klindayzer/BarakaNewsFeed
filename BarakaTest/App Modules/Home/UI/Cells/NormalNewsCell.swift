/*
 *	NormalNewsCell.swift
 *	BarakaTest
 *
 *	Created by Klindayzer on 29/04/2022.
 */

import UIKit

final class NormalNewsCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var newsImageView: UIImageView!
    @IBOutlet private weak var newsTitleLabel: UILabel!
    @IBOutlet private weak var newsDateLabel: UILabel!
    @IBOutlet private weak var newsDescriptionLabel: UILabel!
    @IBOutlet private weak var dimmingView: UIView!
    
    // MARK: - Exposed Methods
    func setupCell(with news: NewsPresenter) {
        
        dimmingView.backgroundColor = (UIColor(named: "black100") ?? .black).withAlphaComponent(0.6)
        
        newsImageView.setImage(url: news.image)
        newsTitleLabel.text = news.title
        newsDateLabel.text = news.date
        newsDescriptionLabel.text = news.description
    }
    
}
