import UIKit


class CatsCollectionViewController: UIViewController {

    private var viewModel = CatsCollectionViewModel()
    
    override func loadView() {
        self.view = CatsCollectionView(delegate: self, dataSource: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let view = self.view as? CatsCollectionView else { fatalError() }

        viewModel.loadCats() { success in
            view.reload()
        }
    }
}


// MARK: UICollectionViewDataSource & UICollectionViewDelegate

extension CatsCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.catsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let view = self.view as? CatsCollectionView else { fatalError() }
        
        let cell = view.dequeCellForIndexPath(indexPath)
        if indexPath.row < self.viewModel.catsArray.count, let url = self.viewModel.catsArray[indexPath.row].url {
            cell.imageView.downloadedFrom(url: url)
        }

        return cell
    }
}
