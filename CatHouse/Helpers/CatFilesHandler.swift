import UIKit


struct CatFilesHandler {
    
    static func saveFileWithId(_ id: String, image: UIImage) -> Bool {
        let url = localImageURLForId(id)
        let imageData = UIImageJPEGRepresentation(image, 0.5)
        do {
            try imageData?.write(to: url)
        } catch {
            return false
        }
        
        return true
    }
    
    static func delteFileWithId(_ id: String) -> Bool {
        let url = localImageURLForId(id)
        do {
            try FileManager.default.removeItem(at: url)
        } catch {
            return false
        }
        
        return true
    }
    
    static func listSavedFiles() -> [Cat] {
        let fileManager = FileManager.default
        let dir = documentsDir()
        guard let paths = try? fileManager.contentsOfDirectory(atPath: dir) else {
            return []
        }
        
        return paths.map { path in
            let imageURL = URL(fileURLWithPath: dir).appendingPathComponent(path)
            let cat = Cat(id: path, image: UIImage(contentsOfFile: imageURL.path))
            return cat
        }
    }
    
    static func documentsDir() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return paths[0]
    }
    
    static func localImageURLForId(_ id: String) -> URL {
        return URL(fileURLWithPath: documentsDir()).appendingPathComponent(id)
    }
}

