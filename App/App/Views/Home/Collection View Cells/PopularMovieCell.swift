//
//  PopularMovieCell.swift
//  App
//
//  Created by Sharetrip-iOS on 19/12/2020.
//

import UIKit
import Kingfisher

class PopularMovieCell: UICollectionViewCell {
    private lazy var bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        backgroundColor = .red
    }
    
    private func setupView() {
        addSubview(bgImageView)
        bgImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        bgImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        bgImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        bgImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bgImageView.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        bgImageView.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
    }
    
    func configure(movie: Movies?) {
        let baseUrl = "https://image.tmdb.org/t/p/w342"
        let url = URL(string: baseUrl + (movie?.posterPath ?? ""))
        let placeholder = UIImage(named: "placeholder")
        bgImageView.kf.indicatorType = .activity
        bgImageView.kf.setImage(with: url, placeholder: placeholder)
    }
}
