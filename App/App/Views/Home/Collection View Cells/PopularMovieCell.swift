//
//  PopularMovieCell.swift
//  App
//
//  Created by Sharetrip-iOS on 19/12/2020.
//

import UIKit
import Kingfisher

class PopularMovieCell: UICollectionViewCell {
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setupUI()
    }
    
    // MARK: - Properties
    private lazy var roundedBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8.0
        view.layer.borderColor = UIColor.systemGray.cgColor
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont.systemFont(ofSize: 12.0, weight: .medium)
        label.textColor = .white
        label.numberOfLines  = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bgImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "placeholder")
        imgView.translatesAutoresizingMaskIntoConstraints  = false
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    func configure(movie: Movies?) {
        let baseUrl = "https://image.tmdb.org/t/p/w342"
        if let mov = movie {
            titleLabel.text = mov.title
           
            let url = URL(string: baseUrl + (mov.posterPath))
            let placeholder = UIImage(named: "placeholder")
            bgImageView.kf.indicatorType = .activity
            bgImageView.kf.setImage(with: url, placeholder: placeholder)
        }
    }
    
}

// MARK: - UI Setup
extension PopularMovieCell {
    private func setupUI() {
        self.contentView.addSubview(roundedBackgroundView)
        roundedBackgroundView.addSubview(bgImageView)
        roundedBackgroundView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            roundedBackgroundView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            roundedBackgroundView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),
            roundedBackgroundView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            roundedBackgroundView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5),
            bgImageView.leadingAnchor.constraint(equalTo: roundedBackgroundView.leadingAnchor, constant: 5),
            bgImageView.topAnchor.constraint(equalTo: roundedBackgroundView.topAnchor, constant: 5),
            bgImageView.trailingAnchor.constraint(equalTo: roundedBackgroundView.trailingAnchor, constant: -5),
            bgImageView.bottomAnchor.constraint(equalTo: roundedBackgroundView.bottomAnchor, constant: -5),
            titleLabel.topAnchor.constraint(equalTo: roundedBackgroundView.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -2),
        ])
        
    }
}
