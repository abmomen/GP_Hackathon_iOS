//
//  TrendingMoviesCell.swift
//  App
//
//  Created by Sharetrip-iOS on 19/12/2020.
//

import UIKit

class TrendingMoviesCell: UITableViewCell {
    
    private lazy var bgImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "placeholder")
        imgView.translatesAutoresizingMaskIntoConstraints  = false
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(video: Video?) {
        let baseUrl = "https://image.tmdb.org/t/p/w342"
        if let vid = video {
            let url = URL(string: baseUrl + (vid.posterPath))
            let placeholder = UIImage(named: "placeholder")
            bgImageView.kf.indicatorType = .activity
            bgImageView.kf.setImage(with: url, placeholder: placeholder)
        }
    }
    
    private func setupView() {
        contentView.addSubview(bgImageView)

        NSLayoutConstraint.activate([
            bgImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            bgImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            bgImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            bgImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
