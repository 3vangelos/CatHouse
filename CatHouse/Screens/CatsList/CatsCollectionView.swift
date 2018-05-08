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
        collectionView.backgroundColor = UIColor.white
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: cellWithReuseIdentifier)
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
        
        super.init(frame: CGRect.null)
        
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
}


// MARK: Public Methods

extension CatsCollectionView {
    
    func dequeCellForIndexPath(_ indexPath: IndexPath) -> ImageCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellWithReuseIdentifier, for: indexPath) as! ImageCell
    }
    
    func reload() {
        self.collectionView.reloadData()
    }
}
