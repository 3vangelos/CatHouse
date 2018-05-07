import SnapKit
import UIKit


class CatsCollectionView: UIView {
    
    private let collectionView: UICollectionView
    private let cellWithReuseIdentifier = "CellWithReuseIdentifier"
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(delegate: UICollectionViewDelegate?, dataSource: UICollectionViewDataSource?) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 1
        flowLayout.minimumInteritemSpacing = 1
        flowLayout.itemSize = CGSize(width: UIScreen.width/2 - 1, height: UIScreen.width/2)
        collectionView = UICollectionView(frame: CGRect.null, collectionViewLayout: flowLayout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellWithReuseIdentifier)
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
        
        super.init(frame: CGRect.null)
        
        collectionView.backgroundColor = UIColor.yellow
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
}


// MARK: Public Methods

extension CatsCollectionView {
    
    func dequeCellForIndexPath(_ indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellWithReuseIdentifier, for: indexPath)
    }
}
