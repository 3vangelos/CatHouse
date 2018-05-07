import UIKit

struct Cat {
    var id: String?
    var url: String?
    var sourceUrl: String?
    var image: UIImage?
    
    init(id: String? = nil, url: String? = nil, sourceUrl: String? = nil, image: UIImage? = nil) {
        self.id = id
        self.url = url
        self.sourceUrl = sourceUrl
        self.image = image
    }
}
