import UIKit


class CatsViewController: UIViewController {

    private let viewModel: CatsViewModelProtocol
    
    init(_ type: TabBarController.screen) {
        viewModel = type == .recent ? RecentCatsViewModel() : LikedCatsViewModel()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = CatsView(delegate: self, dataSource: self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCats()
    }
    
    func loadCats() {
        guard let view = self.view as? CatsView else { fatalError() }
        
        viewModel.loadCats() { success in
            view.reload()
        }
    }
}


// MARK: UICollectionViewDataSource & UICollectionViewDelegate

extension CatsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfCats()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let view = self.view as? CatsView else { fatalError() }
        
        let cell = view.dequeCellForIndexPath(indexPath)
        cell.activitIndicator.startAnimating()
        self.viewModel.loadCatImageForIndex(indexPath.row, completion: { image in
            cell.imageView.image = image
            cell.activitIndicator.stopAnimating()
            cell.activitIndicator.isHidden = true
            cell.layoutIfNeeded()
        })

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let image = (collectionView.cellForItem(at: indexPath) as? ImageCell)?.imageView.image {
            
            self.viewModel.didTapOnImage(image, index: indexPath.row, completion: { _ in
                if self.viewModel is LikedCatsViewModel {
                    self.loadCats()
                }
            })
        }
    }
}
