//
//  PopularMovieCell.swift
//  App
//
//  Created by Sharetrip-iOS on 19/12/2020.
//

import UIKit
import Kingfisher

class PopularMovieCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        containerView.layer.cornerRadius = 8.0
    }
    
    func configure(imageUrl: String) {
        
    }

}
