import UIKit


class LikedCatsViewModel: CatsViewModelProtocol {

    private var catsArray = [Cat]()
    
    func loadCats(_ completion:@escaping (Bool) -> Void) {
        self.catsArray = CatFilesHandler.listSavedFiles()
        completion(true)
    }
    
    func loadCatImageForIndex(_ index: Int, completion: @escaping (UIImage?) -> Void) {
        guard let image = self.catsArray[index].image else {
            completion(nil)
            return
        }
        
        completion(image)
    }
    
    func numberOfCats() -> Int {
        return self.catsArray.count
    }
    
    func didTapOnImage(_ image: UIImage, index: Int, completion:@escaping (Bool) -> Void) {
        guard let catId = self.catsArray[index].id else {
            completion(false)
            return
        }
        
        completion(CatFilesHandler.delteFileWithId(catId))
    }
    
    func catUrlForIndex(_ index: Int) -> String? {
        return self.catsArray[index].url
    }
}
