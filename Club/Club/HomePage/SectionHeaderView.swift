//
//  SectionHeaderView.swift
//  Club
//
//  Created by GEU on 06/02/26.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {

    @IBOutlet var headerButton: UIButton!
    var onHeaderButtonTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        SectionHeaderView.delegate = self
    }
    func configure(with title: String) {
        headerButton.setTitle(title, for: .normal)
    }
    
    @IBAction func ButtonClicked(_ sender: Any) {
        onHeaderButtonTapped?()
    }
    
}
//extension SectionHeaderView: UICollectionViewDelegate{
//        func (_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//            performSegue(withIdentifier: "homeToClubList", sender: nil)
//    }
//}
