//
//  OtherTableViewCell.swift
//  QuickRead
//
//  Created by Dino Martan on 26/04/2021.
//

import UIKit

class OtherTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var categoryLabel: UILabel!

    //MARK: - Public properties
    
    static let identifier = "otherCell"
    
    //MARK: - Lifecycle
    
    func configureCell(category: String) {
        categoryLabel.text = category
    }

}
