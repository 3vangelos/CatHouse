import UIKit

struct Networking {
    static func downloadImageFromUrl(_ url: String, completion:@escaping (UIImage?) -> Void) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    completion(nil)
                    return
            }
            
            DispatchQueue.main.async() {
                completion(image)
            }
            }.resume()
    }
    
    static func downloadCats(_ completion:@escaping ([Cat]) -> Void) {
        URLSession.shared.dataTask(with: URL(string: "http://thecatapi.com/api/images/get?format=xml&results_per_page=100")!) { (data, response, error) -> Void in
            if let data = data {
                let parser = CatsXMLParser { cats in
                    completion(cats)
                }
                parser.loadCatsFromData(data)
            } else {
                completion([])
            }
            }.resume()
    }
}
