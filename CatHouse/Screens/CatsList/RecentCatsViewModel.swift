import UIKit


class RecentCatsViewModel: CatsViewModelProtocol {
    
    private var catsArray = [Cat]()
    
    func loadCats(_ completion:@escaping (Bool) -> Void) {
        let parser = CatsXMLParser { cats in
            self.catsArray = cats
            completion(true)
        }
        parser.loadCats()
    }
    
    func loadCatImageForIndex(_ index: Int, completion: @escaping (UIImage?) -> Void) {
        guard let url = self.catsArray[index].url else {
            completion(nil)
            return
        }
        
        Networking.downloadImageFromUrl(url, completion: completion)
    }
    
    func numberOfCats() -> Int {
        return self.catsArray.count
    }
    
    
    func didTapOnImage(_ image: UIImage, index: Int, completion:@escaping (Bool) -> Void) {
        guard let catId = self.catsArray[index].id else {
            completion(false)
            return
        }
        
        completion(CatFilesHandler.saveFileWithId(catId, image: image))
    }
    
    func catUrlForIndex(_ index: Int) -> String? {
        return self.catsArray[index].url
    }
}
