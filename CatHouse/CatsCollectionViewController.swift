import UIKit


class CatsCollectionViewController: UIViewController {
    
    let catsArray = [Cat(), Cat(), Cat(), Cat(), Cat(), Cat(), Cat(), Cat(), Cat(), Cat()]
    
    override func loadView() {
        self.view = CatsCollectionView(delegate: self, dataSource: self)
    }
}


// MARK: UICollectionViewDataSource & UICollectionViewDelegate

extension CatsCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let view = self.view as? CatsCollectionView else { fatalError() }
        
        guard indexPath.row < catsArray.count, let image = catsArray[indexPath.row].image else {
            return UICollectionViewCell()
        }
        
        let cell = view.dequeCellForIndexPath(indexPath)
        cell.imageView.image = image
        return cell
    }
}
