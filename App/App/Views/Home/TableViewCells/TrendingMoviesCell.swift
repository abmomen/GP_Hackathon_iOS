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
