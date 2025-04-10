import Foundation

struct Book: Identifiable, Codable {
    var id: String
    var title: String
    var authors: String
    var publisher: String
    var coverURL: String
    var descriptionText: String?
}
