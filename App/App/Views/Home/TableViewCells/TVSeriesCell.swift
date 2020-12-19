
import UIKit

class TVSeriesCell: UITableViewCell {
    //CV stands for collection view
    private lazy var tvSeriesCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(tvSeriesCV)
        tvSeriesCV.collectionViewLayout = {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.minimumLineSpacing = 2
            return flowLayout
        }()
        
        tvSeriesCV.delegate = self
        tvSeriesCV.dataSource = self
        tvSeriesCV.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        tvSeriesCV.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        tvSeriesCV.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        tvSeriesCV.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
    }
}

extension TVSeriesCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 110)
    }
}
