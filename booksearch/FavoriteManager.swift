import Foundation

class FavoriteManager {
    private(set) var favorites: [Book] = []

    func addFavorite(book: Book) {
        if !favorites.contains(where: { $0.id == book.id }) {
            favorites.append(book)
            print("\(book.title) added to favorites.")
        }
    }

    func removeFavorite(book: Book) {
        if let index = favorites.firstIndex(where: { $0.id == book.id }) {
            favorites.remove(at: index)
            print("\(book.title) removed from favorites.")
        }
    }

    func listFavorites() {
        if favorites.isEmpty {
            print("No favorites yet.")
        } else {
            for book in favorites {
                print("Favorite: \(book.title), by \(book.authors)")
            }
        }
    }
}
