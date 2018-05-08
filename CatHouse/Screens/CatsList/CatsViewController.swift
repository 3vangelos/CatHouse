import PKHUD
import UIKit


class CatsViewController: UIViewController {

    private var catsView: CatsView!
    private let viewModel: CatsViewModelProtocol
    
    init(_ type: TabBarController.screen) {
        viewModel = type == .recent ? RecentCatsViewModel() : LikedCatsViewModel()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        catsView = CatsView(delegate: self)
        self.view = catsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.viewModel is RecentCatsViewModel {
            catsView.addTarget(self, selector: #selector(refresh))
            loadCats()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.viewModel is LikedCatsViewModel {
            loadCats()
        }
    }
    
    func loadCats() {
        
        viewModel.loadCats() { success in
            self.catsView.reload()
            self.catsView.finishAnimations()
        }
    }
    
    @objc func refresh() {
        loadCats()
    }
}


// MARK: UICollectionViewDataSource & UICollectionViewDelegate

extension CatsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfCats()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = catsView.dequeCellForIndexPath(indexPath)
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
            
            self.viewModel.didTapOnImage(image, index: indexPath.row, completion: { success in
                HUD.flash(success ? .success : .error)
                if self.viewModel is LikedCatsViewModel {
                    self.loadCats()
                }
            })
        }
    }
}
