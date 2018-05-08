import UIKit

struct Cat {
    var id: String?
    var url: String?
    var image: UIImage?
    
    init(id: String? = nil, url: String? = nil, image: UIImage? = nil) {
        self.id = id
        self.url = url
        self.image = image
    }
}
