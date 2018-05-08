import Foundation

class CatsXMLParser: NSObject {
    
    private var data: ([Cat]) -> Void
    
    private var catsArray: [Cat] = []
    private var eName: String = String()
    private var id = String()
    private var url = String()
    private var sourceUrl = String()
    
    init(_ data: @escaping ([Cat]) -> Void) {
        self.data = data
    }
    
    func loadCatsFromData(_ data: Data) {
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
    }
    
    func loadDummyCats() {
        if let path = Bundle.main.path(forResource: "dummy", ofType: "xml") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                loadCatsFromData(data)
            } catch {
                fatalError()
            }
        }
    }
}

extension CatsXMLParser:  XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        eName = elementName
        if elementName == "image" {
            id = String()
            url = String()
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "image" {
            
            var cat = Cat()
            cat.id = id
            cat.url = url
            
            catsArray.append(cat)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if (!data.isEmpty) {
            if eName == "id" {
                id += data
            } else if eName == "url" {
                url += data
            }
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        self.data(catsArray)
    }
}

