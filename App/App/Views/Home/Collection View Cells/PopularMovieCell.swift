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
        containerView.backgroundColor = .white
    }
    
    func configure(movie: Movies?) {
        let baseUrl = "https://image.tmdb.org/t/p/w342"
        let url = URL(string: baseUrl + (movie?.posterPath ?? ""))
        let placeholder = UIImage(named: "placeholder")
        bgImageView.kf.indicatorType = .activity
        bgImageView.kf.setImage(with: url, placeholder: placeholder)
        
        titleLabel.text = "movie title"
    }
}
