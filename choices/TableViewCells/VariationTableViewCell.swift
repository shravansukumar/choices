//
//  VariationTableViewCell.swift
//  choices
//
//  Created by Shravan Sukumar on 18/11/18.
//  Copyright © 2018 shravan. All rights reserved.
//

import UIKit

class VariationTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var inStockLabel: UILabel!
    
    // MARK: - Variables
    var shouldBeDisabled = false

    // MARK: - Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()
        
        shouldBeDisabled = false
    }
    
    // MARK: - Public Methods
    func configure(with variation: Variation) {
        nameLabel.text =  variation.name
        priceLabel.text = "Price: \(variation.price)"
        let instockString = variation.inStock == 0 ? "No" : "Yes"
        inStockLabel.text = "In Stock: \(instockString)"
        
        if shouldBeDisabled {
            backgroundColor = .gray
            isUserInteractionEnabled = false
        } else {
            backgroundColor = .white
            isUserInteractionEnabled = true

        }
    }
}
