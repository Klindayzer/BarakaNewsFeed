/*
 *	StockCell.swift
 *	BarakaTest
 *
 *	Created by Klindayzer on 29/04/2022.
 */

import UIKit

final class StockCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var stockTitleLabel: UILabel!
    @IBOutlet private weak var stockPriceLabel: UILabel!

    // MARK: - Exposed Methods
    func setupCell(stock: StockPresenter) {
        
        setupUI(borderColor: stock.priceColor)
        
        stockTitleLabel.text = stock.title
        stockPriceLabel.text = stock.price
        stockPriceLabel.textColor = stock.priceColor
    }
    
    // MARK: - Protected Methods
    private func setupUI(borderColor: UIColor) {
        
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = borderColor.cgColor
        contentView.layer.cornerRadius = 16
        contentView.clipsToBounds = true
    }
}
