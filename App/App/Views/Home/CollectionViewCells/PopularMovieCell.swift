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
    private lazy var containerView: UIView = {
        let view = UIView()    
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
        self.contentView.addSubview(containerView)
        containerView.layer.cornerRadius = 8.0
        bgImageView.layer.cornerRadius = 8.0
        bgImageView.clipsToBounds = true
        
        containerView.clipsToBounds = true
        containerView.addSubview(bgImageView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            bgImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
            bgImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
            bgImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5),
            bgImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5),
        ])
        
    }
}
