class CatsCollectionViewModel {
    
    var catsArray = [Cat]()
    
    func loadCats(_ completion:@escaping (Bool) -> Void) {
        let parser = CatsXMLParser { cats in
            self.catsArray = cats
            completion(true)
        }
        parser.loadCats()
    }
}
