//
//  TrendingMoviesCell.swift
//  App
//
//  Created by Sharetrip-iOS on 19/12/2020.
//

import UIKit

class TrendingMoviesCell:  UITableViewCell {
    
    private lazy var imgView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "placeholder")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        imgView.backgroundColor = UIColor.white
        contentView.addSubview(imgView)
        imgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imgView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    func configure(video: Video?) {
        let baseUrl = "https://image.tmdb.org/t/p/w342"
        if let vid = video {
            let url = URL(string: baseUrl + (vid.posterPath))
            let placeholder = UIImage(named: "placeholder")
            imgView.kf.indicatorType = .activity
            imgView.kf.setImage(with: url, placeholder: placeholder)
        }
    }

}
