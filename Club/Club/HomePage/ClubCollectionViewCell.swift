//
//  ClubCollectionViewCell.swift
//  Club
//
//  Created by GEU on 04/02/26.
//

import UIKit

class ClubCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var language: UILabel!
    @IBOutlet var theme: UILabel!
    @IBOutlet var number: UILabel!
    @IBOutlet var clubDescription: UILabel!
    @IBOutlet var ClubTitle: UILabel!
    @IBOutlet var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell(club: Club){
        imageView.image = UIImage(named: club.imagePath)
        ClubTitle.text = club.name
        clubDescription.text = club.description
        language.text = club.language
        theme.text = club.category.displayName
        number.text = String(club.memberCount)
        
    }
}
