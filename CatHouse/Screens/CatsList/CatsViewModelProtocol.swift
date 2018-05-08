import UIKit

protocol CatsViewModelProtocol {
    
    func loadCats(_ completion:@escaping (Bool) -> Void)
    
    func loadCatImageForIndex(_ index: Int, completion: @escaping (UIImage?) -> Void)

    func numberOfCats() -> Int
    
    func didTapOnImage(_ image: UIImage, index: Int, completion:@escaping (Bool) -> Void)
    
    func catUrlForIndex(_ index: Int) -> String?
}
