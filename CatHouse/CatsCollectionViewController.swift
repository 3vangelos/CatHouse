import UIKit


class CatsCollectionViewController: UIViewController {
    
    override func loadView() {
        self.view = CatsCollectionView(delegate: self, dataSource: self)
    }
}


// MARK: UICollectionViewDataSource & UICollectionViewDelegate

extension CatsCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let view = self.view as? CatsCollectionView else { fatalError() }
        
        let cell = view.dequeCellForIndexPath(indexPath)
        cell.backgroundColor = UIColor.brown
        cell.layoutIfNeeded()
        return cell
    }
}
