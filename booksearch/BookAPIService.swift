import Foundation

class BookAPIService {
    static func searchBooks(query: String, completion: @escaping ([Book]?) -> Void) {
        guard let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=\(query)") else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(BookSearchResult.self, from: data)
                    completion(decodedData.items)
                } catch {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
        
        task.resume()
    }
}

struct BookSearchResult: Codable {
    var items: [Book]
}
